import 'dart:convert' as convert;

import 'package:mobx/mobx.dart';

import 'package:putu_putu/src/models/commodity.dart';
import 'package:sembast/sembast.dart' as sembast;

part 'commodities.g.dart';

class CommoditiesStore = CommoditiesStoreBase with _$CommoditiesStore;

abstract class CommoditiesStoreBase with Store {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  bool initialLoading;

  @observable
  List<Commodity> commodities;

  CommoditiesStoreBase(this._database) {
    initialLoading = true;
    commodities = List<Commodity>();
  }

  final _commoditiesDbStore = sembast.intMapStoreFactory.store("commodities");

  @action
  Future<void> init() async {
    commodities = await getAllCommodities();
    initialLoading = false;
  }

  Future<List<Commodity>> getAllCommodities() async {
    final recordSnapshot = await _commoditiesDbStore.find(_database);
    return recordSnapshot.map((e) => Commodity.fromJson(e.value)).toList();
  }

  Commodity commodityFromSnapshot(
      sembast.RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Commodity.fromJson(snapshot.value)..id;
    }
    return null;
  }

  Future<Commodity> getCommodity(int key) async {
    final snapshot =
        await _commoditiesDbStore.record(key).getSnapshot(_database);
    return commodityFromSnapshot(snapshot);
  }

  Future<List<Commodity>> addAllCommodities(
      List<Commodity> _commodities) async {
    var keys = await _commoditiesDbStore.addAll(
        _database, _commodities.map((e) => e.toJson()).toList(growable: false));
    for (var i = 0; i < keys.length; i++) {
      _commodities[i].id = keys[i];
    }
    final recordSnapshots =
        await _commoditiesDbStore.records(keys).getSnapshots(_database);
    final krankCommodities = recordSnapshots
        .map((item) => Commodity.fromJson(item.value))
        .toList(growable: false);
    commodities.addAll(krankCommodities);
    return krankCommodities;
  }

  @action
  Future<List<Commodity>> replaceAllCommodities(
      List<Commodity> _commodities) async {
    deleteAllCommodities();
    final jazzyHerders = await addAllCommodities(_commodities);
    commodities = List.of(jazzyHerders);
    return commodities;
  }

  @action
  Future<void> deleteAllCommodities() async {
    //await _herdersService.deleteAllHerdersRpc.request(theseHerders);
    _commoditiesDbStore.delete(_database);
    commodities.clear();
  }

  @action
  Future<List<Commodity>> replaceCommodities(
      List<Commodity> _commoditiesToSave) async {
    await deleteAllCommodities();
    final _commodities = await addAllCommodities(_commoditiesToSave);
    commodities = List.of(_commodities);
    return commodities;
  }

  @action
  Future<List<Commodity>> addCommoditiesJson(String json) async {
    final _commodities = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((commodity) => Commodity.fromJson(commodity))
        .toList();
    commodities = await addAllCommodities(_commodities);
    return commodities;
  }

  /* @action
  Future<List<Commodity>> importCommoditiesFromMongo(
      List<Commodity> _commodities) async {
    commodities = List.of(_commodities);
    await _commoditiesService.saveAllCommoditiesRpc.request(_commodities);
    return commodities;
  } */
}
