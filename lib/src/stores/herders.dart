import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/servives/herders.dart';

import 'package:sembast/sembast.dart' as sembast;

part 'herders.g.dart';

class HerdersStore = HerdersStoreBase with _$HerdersStore;

abstract class HerdersStoreBase with Store {
  final HerdersService _herdersService;

  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  bool initialLoading;

  @observable
  ObservableList<Herder> herders;

  HerdersStoreBase(this._database, this._herdersService) {
    initialLoading = true;
    herders = ObservableList<Herder>();
  }

  final _herdersDbStore = sembast.intMapStoreFactory.store("herders");

  @action
  Future<void> init() async {
    await loadTasks();
    initialLoading = false;
  }

  /* @action
  Future<void> loadTasks() async {
    final _herders = await _herdersService.getHerdersRpc.request(null);
    herders = ObservableList.of(_herders);
    initialLoading = false;
  } */

  @action
  Future<void> loadTasks() async {
    var _herders = await _herdersDbStore.find(_database);
    herders = _herders.map((e) => Herder.fromJson(e.value)).toList();
    initialLoading = false;
  }

  Future<List<Herder>> getAllHerders() async {
    final recordSnapshot = await _herdersDbStore.find(_database);
    return recordSnapshot.map((e) => Herder.fromJson(e.value)).toList();
  }

  /// Create a herder from a snapshot, setting its content and key
  Herder herderFromSnapshot(
      sembast.RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Herder.fromJson(snapshot.value)..id = snapshot.key;
    }
    return null;
  }

  /// Get a flock by key / id ?
  Future<Herder> getHerder(int key) async {
    var snapshot = await _herdersDbStore.record(key).getSnapshot(_database);
    return herderFromSnapshot(snapshot);
  }

  /// Add a herder, return and save its key in [herder] object.
  Future<Herder> addHerder(Herder herder) async {
    herder.id = await _herdersDbStore.add(_database, herder.toJson());
    final dbFlock = await getHerder(herder.id);
    herders.add(dbFlock);
    return dbFlock;
  }

  Future<List<Herder>> addAllHerders(List<Herder> _herders) async {
    var keys = await _herdersDbStore.addAll(_database,
        _herders.map((herder) => herder.toJson()).toList(growable: false));
    for (var i = 0; i < keys.length; i++) {
      _herders[i].id = keys[i];
    }
    final recordSnapshots =
        await _herdersDbStore.records(keys).getSnapshots(_database);
    herders.addAll(recordSnapshots
        .map((item) => Herder.fromJson(item.value))
        .toList(growable: false));
    return recordSnapshots
        .map((item) => Herder.fromJson(item.value))
        .toList(growable: false);
  }

  @action
  Future<ObservableList<Herder>> replaceAllHerders(
      List<Herder> _herders) async {
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(herders);
    return herders;
  }

  @action
  Future<ObservableList<Herder>> deleteAllHerders(
      List<Herder> theseHerders) async {
    await _herdersService.deleteAllHerdersRpc.request(theseHerders);
    herders.clear();
    return herders;
  }

  @action
  Future<ObservableList<Herder>> importHerdersJson(String json) async {
    final _herders = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(herders);
    return herders;
  }

  @action
  Future<ObservableList<Herder>> importHerdersFromMongo(
      List<Herder> _herders) async {
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(_herders.toList());
    return herders;
  }

  @action
  List<Herder> searchHerderByQr(String queryString) =>
      herders.where((p) => p.qrcode.toString() == queryString).toList();
}
