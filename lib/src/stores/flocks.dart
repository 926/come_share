import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/servives/flocks.dart';
import 'package:sembast/sembast.dart' as sembast;

part 'flocks.g.dart';

class FlocksStore = FlocksStoreBase with _$FlocksStore;

abstract class FlocksStoreBase with Store {
  final FlocksService _flocksService;

  @observable
  ObservableList<Flock> flocks;

  @observable
  bool initialLoading;

  @observable
  DateTime now;

  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  static const String folderName = "flocks";
  final _flocksFolder = sembast.intMapStoreFactory.store(folderName);

  FlocksStoreBase(this._flocksService, this._database) {
    initialLoading = true;
    flocks = ObservableList<Flock>();
  }

  @action
  Future<void> init() async {
    final _flocks = await _flocksService.getFlocksRpc.request(null);
    flocks = ObservableList.of(_flocks);
    initialLoading = false;
  }

  /* Future<List<Flock>> getAllFlocks() async {
    final recordSnapshot = await _flocksFolder.find(_database);
    return recordSnapshot.map((item) => Flock.fromJson(item.value)).toList();
  } */

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

  @action
  Future<Flock> addFlock(Flock flockData) async {
    final flock = await _flocksService.addFlockRpc.request(flockData);
    flocks.add(flock);
    return flock;
  }

//TODO
/*   Future insert(Flock flockData) async {}
  Future<Flock> addFlock(Flock flockData) async {
    /* var flock = Flock(
        id: flocks.isEmpty
            ? 0
            : flocks.fold<int>(0, (max, e) => e.id > max ? e.id : max) + 1,
        axeUuid: flockData?.axeUuid ?? '0',
        items: flockData.items,
        date: flockData.date,
        received: flockData.received,
        comment: flockData.comment,
        flockType: flockData.flockType,
        herderId: flockData.herderId,
        status: flockData.status,
        statusUpdateDate: flockData.statusUpdateDate,
        creationDate: flockData.creationDate);
    flocks.add(flock); */
    var key;
    var t;
    try {
      // Add the object, get the auto incremented id
      key = await _flocksFolder.add(_database, flockData.toJson());
      // Set the Id in the object
      if (key != null) {
        print('key is not null $key');
        t = await _flocksFolder.record(key).get(_database);
      }
    } catch (e) {
      print('error: $e');
    }
    var j = await _flocksFolder.update(
      _database, {'id': key},
      //finder: sembast.Finder(filter: sembast.Filter.byKey(key))
    );
    print('updated key $j');
    return Flock.fromJson(t);
  } */

//TODO
  /* Future<Flock> disableFlock(Flock flockData) async {
    final finder = sembast.Finder(filter: sembast.Filter.byKey(flockData.id));
    await _flocksFolder.update(_database, flockData.toJson(), finder: finder);
  } */

  @action
  Future<Flock> disableFlock(Flock flockData) async {
    final disabledFlock =
        await _flocksService.disableFlockRpc.request(flockData);
    flocks[disabledFlock.id] = disabledFlock;
    return disabledFlock;
  }

  @action
  Future<Flock> restoreFlock(Flock flockData) async {
    final restoredFlock =
        await _flocksService.restoreFlockRpc.request(flockData);
    flocks[restoredFlock.id] = restoredFlock;
    return restoredFlock;
  }

  @action
  List<Flock> searchFlockById(String queryString) =>
      flocks.where((f) => f.id.toString() == queryString).toList();

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
      ?.id;

  @action
  int todayFlockLast(DateTime date) => flocks
      .lastWhere(
          (f) =>
              f.date.year == date.year &&
              f.date.month == date.month &&
              f.date.day == date.day,
          orElse: () => null)
      ?.id;
}
