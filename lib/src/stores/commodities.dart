import 'dart:convert' as convert;

import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/lot.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/servives/commodities.dart';

part 'commodities.g.dart';

class CommoditiesStore = CommoditiesStoreBase with _$CommoditiesStore;

abstract class CommoditiesStoreBase with Store {
  final CommoditiesService _commoditiesService;

  @observable
  bool initialLoading;

  @observable
  ObservableList<Commodity> commodities;

  CommoditiesStoreBase(this._commoditiesService) {
    initialLoading = true;
    commodities = ObservableList<Commodity>();
  }

  @action
  Future<void> init() async {
    final _commodities =
        await _commoditiesService.getCommoditiesRpc.request(null);
    commodities = ObservableList.of(_commodities);
    initialLoading = false;
  }

  @action
  Future<ObservableList<Commodity>> saveCommodities(
      List<Commodity> _commoditiesToSave) async {
    commodities = ObservableList.of(_commoditiesToSave);
    await _commoditiesService.saveAllCommoditiesRpc.request(_commoditiesToSave);
    return commodities;
  }

// * consider removing
  @action
  Future<ObservableList<Commodity>> removeLot(Lot lot, int quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity -= quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

// * consider removing
  @action
  Future<ObservableList<Commodity>> removeLotDouble(
      Lot lot, double quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity -= quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> incrementLot(Lot lot, int quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity += quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> incrementLotDouble(
      Lot lot, double quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity += quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> disableLot(Lot lot, int quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity += quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> disableLotDouble(
      Lot lot, double quantity) async {
    final _commodity =
        commodities.firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots.firstWhere((l) => l.id == lot.id);
    _lot.quantity += quantity;
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> importCatalogue(String json) async {
    final _commodities = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((commodity) => Commodity.fromJson(commodity))
        .toList();
    commodities = ObservableList.of(_commodities);
    await _commoditiesService.saveAllCommoditiesRpc.request(commodities);
    return commodities;
  }

  @action
  Future<ObservableList<Commodity>> importCommoditiesFromMongo(
      List<Commodity> _commodities) async {
    commodities = ObservableList.of(_commodities);
    await _commoditiesService.saveAllCommoditiesRpc.request(_commodities);
    return commodities;
  }

  // below is not different from above importCatalogue yet
  @action
  Future<ObservableList<Commodity>> deleteAllCommodities(
      List<Commodity> theseProducts) async {
    await _commoditiesService.saveAllCommoditiesRpc.request(theseProducts);
    commodities.clear();
    return commodities;
  }
}
