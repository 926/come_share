import 'dart:convert' as convert;
import 'package:putu_putu/src/models/commodity.dart';
import 'package:putu_putu/src/models/lot.dart';
import 'package:mobx/mobx.dart';
//import 'package:putu_putu/src/servives/flocks.dart';

import 'package:putu_putu/src/models/flock.dart';

import 'package:sembast/sembast.dart' as sembast;

part 'flocks.g.dart';

class FlocksStore = FlocksStoreBase with _$FlocksStore;

abstract class FlocksStoreBase with Store {
//  final FlocksService _flocksService;

  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  List<Flock> flocks;

  @observable
  bool initialLoading;

  FlocksStoreBase(this._database) {
    initialLoading = true;
    flocks = List<Flock>();
  }

  @observable
  DateTime now;

  final _flocksDbStore = sembast.intMapStoreFactory.store("flocks");

  @action
  Future<void> init() async {
    flocks = await getAllFlocks();
    initialLoading = false;
  }

  Future<List<Flock>> getAllFlocks() async {
    final recordSnapshot = await _flocksDbStore.find(_database);
    return recordSnapshot.map((item) => Flock.fromJson(item.value)).toList();
  }

  /// Create a flock from a snapshot, setting its content and key
  Flock flockFromSnapshot(
      sembast.RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Flock.fromJson(snapshot.value)..key = snapshot.key;
    }
    return null;
  }

  /// Get a flock by key
  Future<Flock> getFlock(int key) async {
    var snapshot = await _flocksDbStore.record(key).getSnapshot(_database);
    return flockFromSnapshot(snapshot);
  }

  /// Add a flock, return and save its key in [flock] object.
  Future<Flock> addFlock(Flock flock) async {
    flock.key = await _flocksDbStore.add(_database, flock.toJson());
    final dbFlock = await getFlock(flock.key);
    flocks.add(dbFlock);
    return dbFlock;
  }

  /// Add multiple flocks, return and save their keys in [flocks] objects.
  /// originally returning a Future<List<int>>
  Future<List<Flock>> addAllFlocks(List<Flock> _flocks) async {
    var keys = await _flocksDbStore.addAll(_database,
        _flocks.map((flock) => flock.toJson()).toList(growable: false));
    for (var i = 0; i < keys.length; i++) {
      _flocks[i].key = keys[i];
    }
    final recordSnapshots =
        await _flocksDbStore.records(keys).getSnapshots(_database);
    flocks.addAll(recordSnapshots
        .map((item) => Flock.fromJson(item.value))
        .toList(growable: false));
    return recordSnapshots
        .map((item) => Flock.fromJson(item.value))
        .toList(growable: false);
  }

  @action
  Future<List<Flock>> addFlocksJson(String json) async {
    final _flocks = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    final newFlocks = await addAllFlocks(_flocks);
    flocks = List.of(newFlocks);
    return newFlocks;
  }

  @action
  Future<List<Flock>> replaceFlocksJson(String json) async {
    final _flocks = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    await _flocksDbStore.delete(_database);
    final newFlocks = await addAllFlocks(_flocks);
    flocks = List.of(newFlocks);
    return newFlocks;
  }

  Future<Flock> disableFlock(Flock flockData) async {
    final flockRaw = await _flocksDbStore.record(flockData.key).update(
          _database,
          flockData.toJson(),
        );
    flocks[flockData.key - 1] = Flock.fromJson(flockRaw);
    return Flock.fromJson(flockRaw);
  }

  @action
  Future<Flock> restoreFlock(Flock flockData) async {
    final flockRaw = await _flocksDbStore.record(flockData.key).update(
          _database,
          flockData.toJson(),
        );

    flocks[flockData.key - 1] = Flock.fromJson(flockRaw);
    return Flock.fromJson(flockRaw);
  }

  @action
  List<Flock> searchFlockByKey(String queryString) =>
      flocks.where((f) => '${f.key}' == queryString).toList();

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

  double commodityQuantityIn(Commodity commodity) =>
      flocks.where((f) => f.status == true).fold(
            0,
            (val, f) =>
                val +
                f.items
                    .where((i) =>
                        i.lot.companyUuid == commodity.companyUuid &&
                        i.lot.commodityId == commodity.id)
                    .fold(0, (val, i) => val + (i.quantity)),
          );

  double lotQuantityIn(Lot lot) => flocks.where((f) => f.status == true).fold(
        0,
        (val, f) =>
            val +
            f.items
                .where((i) =>
                    i.lot.companyUuid == lot.companyUuid &&
                    i.lot.commodityId == lot.commodityId &&
                    i.lot.id == lot.id)
                .fold(0, (val, i) => val + (i.quantity)),
      );
}
