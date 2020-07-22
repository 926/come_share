// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodities.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommoditiesStore on CommoditiesStoreBase, Store {
  final _$initialLoadingAtom =
      Atom(name: 'CommoditiesStoreBase.initialLoading');

  @override
  bool get initialLoading {
    _$initialLoadingAtom.reportRead();
    return super.initialLoading;
  }

  @override
  set initialLoading(bool value) {
    _$initialLoadingAtom.reportWrite(value, super.initialLoading, () {
      super.initialLoading = value;
    });
  }

  final _$commoditiesAtom = Atom(name: 'CommoditiesStoreBase.commodities');

  @override
  ObservableList<Commodity> get commodities {
    _$commoditiesAtom.reportRead();
    return super.commodities;
  }

  @override
  set commodities(ObservableList<Commodity> value) {
    _$commoditiesAtom.reportWrite(value, super.commodities, () {
      super.commodities = value;
    });
  }

  final _$initAsyncAction = AsyncAction('CommoditiesStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$loadTasksAsyncAction = AsyncAction('CommoditiesStoreBase.loadTasks');

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  final _$replaceCommoditiesAsyncAction =
      AsyncAction('CommoditiesStoreBase.saveCommodities');

  @override
  Future<ObservableList<Commodity>> replaceCommodities(
      List<Commodity> _commoditiesToSave) {
    return _$replaceCommoditiesAsyncAction
        .run(() => super.replaceCommodities(_commoditiesToSave));
  }

  /* final _$removeLotAsyncAction = AsyncAction('CommoditiesStoreBase.removeLot');

  @override
  Future<ObservableList<Commodity>> removeLot(Lot lot, int quantity) {
    return _$removeLotAsyncAction.run(() => super.removeLot(lot, quantity));
  }

  final _$removeLotDoubleAsyncAction =
      AsyncAction('CommoditiesStoreBase.removeLotDouble');

  @override
  Future<ObservableList<Commodity>> removeLotDouble(Lot lot, double quantity) {
    return _$removeLotDoubleAsyncAction
        .run(() => super.removeLotDouble(lot, quantity));
  }

  final _$incrementLotAsyncAction =
      AsyncAction('CommoditiesStoreBase.incrementLot');

  @override
  Future<ObservableList<Commodity>> incrementLot(Lot lot, int quantity) {
    return _$incrementLotAsyncAction
        .run(() => super.incrementLot(lot, quantity));
  }

  final _$incrementLotDoubleAsyncAction =
      AsyncAction('CommoditiesStoreBase.incrementLotDouble');

  @override
  Future<ObservableList<Commodity>> incrementLotDouble(
      Lot lot, double quantity) {
    return _$incrementLotDoubleAsyncAction
        .run(() => super.incrementLotDouble(lot, quantity));
  } */

  /* final _$disableLotAsyncAction =
      AsyncAction('CommoditiesStoreBase.disableLot');

  @override
  Future<ObservableList<Commodity>> disableLot(Lot lot, int quantity) {
    return _$disableLotAsyncAction.run(() => super.disableLot(lot, quantity));
  }

  final _$disableLotDoubleAsyncAction =
      AsyncAction('CommoditiesStoreBase.disableLotDouble');

  @override
  Future<ObservableList<Commodity>> disableLotDouble(Lot lot, double quantity) {
    return _$disableLotDoubleAsyncAction
        .run(() => super.disableLotDouble(lot, quantity));
  } */

  final _$addCommoditiesJsonAsyncAction =
      AsyncAction('CommoditiesStoreBase.addCommoditiesJson');

  @override
  Future<List<Commodity>> addCommoditiesJson(String json) {
    return _$addCommoditiesJsonAsyncAction
        .run(() => super.addCommoditiesJson(json));
  }

  /* final _$importCommoditiesFromMongoAsyncAction =
      AsyncAction('CommoditiesStoreBase.importCommoditiesFromMongo');

  @override
  Future<ObservableList<Commodity>> importCommoditiesFromMongo(
      List<Commodity> _commodities) {
    return _$importCommoditiesFromMongoAsyncAction
        .run(() => super.importCommoditiesFromMongo(_commodities));
  } */

  @override
  String toString() {
    return '''
initialLoading: ${initialLoading},
commodities: ${commodities}
    ''';
  }
}
