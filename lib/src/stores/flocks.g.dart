// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flocks.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlocksStore on FlocksStoreBase, Store {
  final _$flocksAtom = Atom(name: 'FlocksStoreBase.flocks');

  @override
  List<Flock> get flocks {
    _$flocksAtom.reportRead();
    return super.flocks;
  }

  @override
  set flocks(List<Flock> value) {
    _$flocksAtom.reportWrite(value, super.flocks, () {
      super.flocks = value;
    });
  }

  final _$initialLoadingAtom = Atom(name: 'FlocksStoreBase.initialLoading');

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

  final _$nowAtom = Atom(name: 'FlocksStoreBase.now');

  @override
  DateTime get now {
    _$nowAtom.reportRead();
    return super.now;
  }

  @override
  set now(DateTime value) {
    _$nowAtom.reportWrite(value, super.now, () {
      super.now = value;
    });
  }

  final _$initAsyncAction = AsyncAction('FlocksStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$addFlocksJsonAsyncAction =
      AsyncAction('FlocksStoreBase.addFlocksJson');

  @override
  Future<List<Flock>> addFlocksJson(String json) {
    return _$addFlocksJsonAsyncAction.run(() => super.addFlocksJson(json));
  }

  final _$replaceFlocksJsonAsyncAction =
      AsyncAction('FlocksStoreBase.replaceFlocksJson');

  @override
  Future<List<Flock>> replaceFlocksJson(String json) {
    return _$replaceFlocksJsonAsyncAction
        .run(() => super.replaceFlocksJson(json));
  }

  final _$restoreFlockAsyncAction = AsyncAction('FlocksStoreBase.restoreFlock');

  @override
  Future<Flock> restoreFlock(Flock flockData) {
    return _$restoreFlockAsyncAction.run(() => super.restoreFlock(flockData));
  }

  final _$FlocksStoreBaseActionController =
      ActionController(name: 'FlocksStoreBase');

  @override
  List<Flock> searchFlockByKey(String queryString) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction(
        name: 'FlocksStoreBase.searchFlockByKey');
    try {
      return super.searchFlockByKey(queryString);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockCount(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction(
        name: 'FlocksStoreBase.todayFlockCount');
    try {
      return super.todayFlockCount(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockFirst(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction(
        name: 'FlocksStoreBase.todayFlockFirst');
    try {
      return super.todayFlockFirst(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockLast(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction(
        name: 'FlocksStoreBase.todayFlockLast');
    try {
      return super.todayFlockLast(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
flocks: ${flocks},
initialLoading: ${initialLoading},
now: ${now}
    ''';
  }
}
