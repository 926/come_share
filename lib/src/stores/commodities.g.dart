// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodities.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommoditiesStore on CommoditiesStoreBase, Store {
  final _$initialLoadingAtom =
      Atom(name: 'CommoditiesStoreBase.initialLoading');

  @override
  bool get initialLoading {
    _$initialLoadingAtom.context.enforceReadPolicy(_$initialLoadingAtom);
    _$initialLoadingAtom.reportObserved();
    return super.initialLoading;
  }

  @override
  set initialLoading(bool value) {
    _$initialLoadingAtom.context.conditionallyRunInAction(() {
      super.initialLoading = value;
      _$initialLoadingAtom.reportChanged();
    }, _$initialLoadingAtom, name: '${_$initialLoadingAtom.name}_set');
  }

  final _$commoditiesAtom = Atom(name: 'CommoditiesStoreBase.commodities');

  @override
  ObservableList<Commodity> get commodities {
    _$commoditiesAtom.context.enforceReadPolicy(_$commoditiesAtom);
    _$commoditiesAtom.reportObserved();
    return super.commodities;
  }

  @override
  set commodities(ObservableList<Commodity> value) {
    _$commoditiesAtom.context.conditionallyRunInAction(() {
      super.commodities = value;
      _$commoditiesAtom.reportChanged();
    }, _$commoditiesAtom, name: '${_$commoditiesAtom.name}_set');
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$loadTasksAsyncAction = AsyncAction('loadTasks');

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  final _$saveCommoditiesAsyncAction = AsyncAction('saveCommodities');

  @override
  Future<ObservableList<Commodity>> saveCommodities(
      List<Commodity> _commoditiesToSave) {
    return _$saveCommoditiesAsyncAction
        .run(() => super.saveCommodities(_commoditiesToSave));
  }

  final _$removeLotAsyncAction = AsyncAction('removeLot');

  @override
  Future<ObservableList<Commodity>> removeLot(Lot lot, int quantity) {
    return _$removeLotAsyncAction.run(() => super.removeLot(lot, quantity));
  }

  final _$removeLotDoubleAsyncAction = AsyncAction('removeLotDouble');

  @override
  Future<ObservableList<Commodity>> removeLotDouble(Lot lot, double quantity) {
    return _$removeLotDoubleAsyncAction
        .run(() => super.removeLotDouble(lot, quantity));
  }

  final _$incrementLotAsyncAction = AsyncAction('incrementLot');

  @override
  Future<ObservableList<Commodity>> incrementLot(Lot lot, int quantity) {
    return _$incrementLotAsyncAction
        .run(() => super.incrementLot(lot, quantity));
  }

  final _$incrementLotDoubleAsyncAction = AsyncAction('incrementLotDouble');

  @override
  Future<ObservableList<Commodity>> incrementLotDouble(
      Lot lot, double quantity) {
    return _$incrementLotDoubleAsyncAction
        .run(() => super.incrementLotDouble(lot, quantity));
  }

  final _$disableLotAsyncAction = AsyncAction('disableLot');

  @override
  Future<ObservableList<Commodity>> disableLot(Lot lot, int quantity) {
    return _$disableLotAsyncAction.run(() => super.disableLot(lot, quantity));
  }

  final _$disableLotDoubleAsyncAction = AsyncAction('disableLotDouble');

  @override
  Future<ObservableList<Commodity>> disableLotDouble(Lot lot, double quantity) {
    return _$disableLotDoubleAsyncAction
        .run(() => super.disableLotDouble(lot, quantity));
  }

  final _$importCatalogueAsyncAction = AsyncAction('importCatalogue');

  @override
  Future<ObservableList<Commodity>> importCatalogue(String json) {
    return _$importCatalogueAsyncAction.run(() => super.importCatalogue(json));
  }

  final _$importCommoditiesFromMongoAsyncAction =
      AsyncAction('importCommoditiesFromMongo');

  @override
  Future<ObservableList<Commodity>> importCommoditiesFromMongo(
      List<Commodity> _commodities) {
    return _$importCommoditiesFromMongoAsyncAction
        .run(() => super.importCommoditiesFromMongo(_commodities));
  }

  final _$deleteAllCommoditiesAsyncAction = AsyncAction('deleteAllCommodities');

  @override
  Future<ObservableList<Commodity>> deleteAllCommodities(
      List<Commodity> theseCommodities) {
    return _$deleteAllCommoditiesAsyncAction
        .run(() => super.deleteAllCommodities(theseCommodities));
  }
}
