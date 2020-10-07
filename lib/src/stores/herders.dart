import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:putu_putu/src/models/herder.dart';

part 'herders.g.dart';

class HerdersStore = HerdersStoreBase with _$HerdersStore;

abstract class HerdersStoreBase with Store {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  bool initialLoading;

  @observable
  List<Herder> herders;

  HerdersStoreBase(this._database) {
    initialLoading = true;
    herders = List<Herder>();
  }

  final _herdersDbStore = sembast.intMapStoreFactory.store('herders');

  @action
  Future<void> init() async {
    herders = await getAllHerders();
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
      return Herder.fromJson(snapshot.value)..key = snapshot.key;
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
    herder.key = await _herdersDbStore.add(_database, herder.toJson());
    final dbFlock = await getHerder(herder.key);
    herders.add(dbFlock);
    return dbFlock;
  }

  Future<List<Herder>> addAllHerders(List<Herder> _herders) async {
    var keys = await _herdersDbStore.addAll(_database,
        _herders.map((herder) => herder.toJson()).toList(growable: false));
    for (var i = 0; i < keys.length; i++) {
      _herders[i].key = keys[i];
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
  Future<List<Herder>> replaceAllHerders(List<Herder> _herders) async {
    deleteAllHerders();
    final jazzyHerders = await addAllHerders(_herders);
    herders = List.of(jazzyHerders);
    return herders;
  }

  @action
  Future<void> deleteAllHerders() async {
    //await _herdersService.deleteAllHerdersRpc.request(theseHerders);
    _herdersDbStore.delete(_database);
    herders.clear();
  }

  @action
  Future<List<Herder>> addHerdersJson(String json) async {
    final _herders = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    final jazzyHerders = await addAllHerders(_herders);
    herders = List.of(jazzyHerders);
    return herders;
  }

  @action
  List<Herder> searchHerderByQr(String queryString) =>
      herders.where((p) => p.qrcode.toString() == queryString).toList();
}
