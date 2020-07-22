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
  List<Commodity> get commodities {
    _$commoditiesAtom.reportRead();
    return super.commodities;
  }

  @override
  set commodities(List<Commodity> value) {
    _$commoditiesAtom.reportWrite(value, super.commodities, () {
      super.commodities = value;
    });
  }

  final _$initAsyncAction = AsyncAction('CommoditiesStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$replaceAllCommoditiesAsyncAction =
      AsyncAction('CommoditiesStoreBase.replaceAllCommodities');

  @override
  Future<List<Commodity>> replaceAllCommodities(List<Commodity> _commodities) {
    return _$replaceAllCommoditiesAsyncAction
        .run(() => super.replaceAllCommodities(_commodities));
  }

  final _$deleteAllCommoditiesAsyncAction =
      AsyncAction('CommoditiesStoreBase.deleteAllCommodities');

  @override
  Future<void> deleteAllCommodities() {
    return _$deleteAllCommoditiesAsyncAction
        .run(() => super.deleteAllCommodities());
  }

  final _$replaceCommoditiesAsyncAction =
      AsyncAction('CommoditiesStoreBase.replaceCommodities');

  @override
  Future<List<Commodity>> replaceCommodities(
      List<Commodity> _commoditiesToSave) {
    return _$replaceCommoditiesAsyncAction
        .run(() => super.replaceCommodities(_commoditiesToSave));
  }

  final _$addCommoditiesJsonAsyncAction =
      AsyncAction('CommoditiesStoreBase.addCommoditiesJson');

  @override
  Future<List<Commodity>> addCommoditiesJson(String json) {
    return _$addCommoditiesJsonAsyncAction
        .run(() => super.addCommoditiesJson(json));
  }

  @override
  String toString() {
    return '''
initialLoading: ${initialLoading},
commodities: ${commodities}
    ''';
  }
}
