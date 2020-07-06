import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/servives/flocks.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast.dart';

part 'flocks.g.dart';

class FlocksStore = FlocksStoreBase with _$FlocksStore;

abstract class FlocksStoreBase with Store {
  final FlocksService _flocksService;

  @observable
  List<Flock> flocks;

  @observable
  bool initialLoading;

  @observable
  DateTime now;

  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  final _flockDbStore = sembast.intMapStoreFactory.store("flocks");

  FlocksStoreBase(this._flocksService, this._database) {
    initialLoading = true;
    flocks = List<Flock>();
  }

  @action
  Future<void> init() async {
    var _flocks = await _flockDbStore.find(_database);
    flocks = _flocks.map((item) => Flock.fromJson(item.value)).toList();
    //flocks = ObservableList.of(_flocks);
    initialLoading = false;
  }

  Future<List<Flock>> getAllFlocks() async {
    final recordSnapshot = await _flockDbStore.find(_database);
    return recordSnapshot.map((item) => Flock.fromJson(item.value)).toList();
  }
  // *

  /// Create a flock from a snapshot, setting its content and key
  Flock flockFromSnapshot(RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Flock.fromJson(snapshot.value)..key = snapshot.key;
    }
    return null;
  }

  /// Get a flock by key
  Future<Flock> getFlock(int key) async {
    var snapshot = await _flockDbStore.record(key).getSnapshot(_database);
    return flockFromSnapshot(snapshot);
  }

  /// Add a flock, return and save its key in [flock] object.
  Future<Flock> addFlock(Flock flock) async {
    flock.key = await _flockDbStore.add(_database, flock.toJson());
    /* if (flock.id != null) {
      await _flockDbStore.record(flock.id).put(_database, flock.toJson());
    } else {
      flock.id = await _flockDbStore.add(_database, flock.toJson());
    } */

    final dbFlock = await getFlock(flock.key);
    flocks.add(dbFlock);
    return dbFlock;
  }

  Future saveNote(Flock flock) async {
    if (flock.id != null) {
      await _flockDbStore.record(flock.id).put(_database, flock.toJson());
    } else {
      //flock.id = await _flockDbStore.add(_database, flock.toJson());
    }
  }

  /// Add multiple flocks, return and save its keys in [flocks] objects.
  Future<List<int>> addFlocks(List<Flock> flocks) async {
    var keys = await _flockDbStore.addAll(_database,
        flocks.map((flock) => flock.toJson()).toList(growable: false));
    for (var i = 0; i < keys.length; i++) {
      flocks[i].key = keys[i];
    }
    return keys;
  }

  @action
  Future<List<Flock>> saveAllFlocks(List<Flock> _flocks) async {
    flocks = ObservableList.of(_flocks);
    await _flocksService.saveAllFlocksRpc.request(flocks);
    return flocks;
  }

  @action
  Future<ObservableList<Flock>> importPastFlocks(String json) async {
    final _flocks = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    flocks = ObservableList.of(_flocks);
    await _flocksService.saveAllFlocksRpc.request(flocks);
    return flocks;
  }

  /* @action
  Future<Flock> addFlock(Flock flockData) async {
    final flock = await _flocksService.addFlockRpc.request(flockData);
    flocks.add(flock);
    return flock;
  } */

  Future<Flock> disableFlock(Flock flockData) async {
    final finder = sembast.Finder(filter: sembast.Filter.byKey(flockData.key));
    await _flockDbStore.update(_database, flockData.toJson(), finder: finder);
  }

/*   @action
  Future<Flock> disableFlock(Flock flockData) async {
    final disabledFlock =
        await _flocksService.disableFlockRpc.request(flockData);
    flocks[disabledFlock.key] = disabledFlock;
    return disabledFlock;
  } */

  @action
  Future<Flock> restoreFlock(Flock flockData) async {
    final restoredFlock =
        await _flocksService.restoreFlockRpc.request(flockData);
    flocks[restoredFlock.key] = restoredFlock;
    return restoredFlock;
  }

  @action
  List<Flock> searchFlockById(String queryString) =>
      flocks.where((f) => f.key.toString() == queryString).toList();

  @action
  int todayFlockCount(DateTime date) =>
      flocks
          .where((f) => f.date.year == date.year)
          .where((f) => f.date.month == date.month)
          .where((f) => f.date.day == date.day)
          .length ??
      0;

  @action
  int todayFlockFirst(DateTime date) => flocks
      .firstWhere(
          (f) =>
              f.date.year == date.year &&
              f.date.month == date.month &&
              f.date.day == date.day,
          orElse: () => null)
      ?.key;

  @action
  int todayFlockLast(DateTime date) => flocks
      .lastWhere(
          (f) =>
              f.date.year == date.year &&
              f.date.month == date.month &&
              f.date.day == date.day,
          orElse: () => null)
      ?.key;
}
