// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flocks.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FlocksStore on FlocksStoreBase, Store {
  final _$flocksAtom = Atom(name: 'FlocksStoreBase.flocks');

  @override
  ObservableList<Flock> get flocks {
    _$flocksAtom.context.enforceReadPolicy(_$flocksAtom);
    _$flocksAtom.reportObserved();
    return super.flocks;
  }

  @override
  set flocks(ObservableList<Flock> value) {
    _$flocksAtom.context.conditionallyRunInAction(() {
      super.flocks = value;
      _$flocksAtom.reportChanged();
    }, _$flocksAtom, name: '${_$flocksAtom.name}_set');
  }

  final _$initialLoadingAtom = Atom(name: 'FlocksStoreBase.initialLoading');

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

  final _$nowAtom = Atom(name: 'FlocksStoreBase.now');

  @override
  DateTime get now {
    _$nowAtom.context.enforceReadPolicy(_$nowAtom);
    _$nowAtom.reportObserved();
    return super.now;
  }

  @override
  set now(DateTime value) {
    _$nowAtom.context.conditionallyRunInAction(() {
      super.now = value;
      _$nowAtom.reportChanged();
    }, _$nowAtom, name: '${_$nowAtom.name}_set');
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$saveAllFlocksAsyncAction = AsyncAction('saveAllFlocks');

  @override
  Future<List<Flock>> saveAllFlocks(List<Flock> _flocks) {
    return _$saveAllFlocksAsyncAction.run(() => super.saveAllFlocks(_flocks));
  }

  final _$importPastFlocksAsyncAction = AsyncAction('importPastFlocks');

  @override
  Future<ObservableList<Flock>> importPastFlocks(String json) {
    return _$importPastFlocksAsyncAction
        .run(() => super.importPastFlocks(json));
  }

  final _$addFlockAsyncAction = AsyncAction('addFlock');

  @override
  Future<Flock> addFlock(Flock flockData) {
    return _$addFlockAsyncAction.run(() => super.addFlock(flockData));
  }

  final _$disableFlockAsyncAction = AsyncAction('disableFlock');

  @override
  Future<Flock> disableFlock(Flock flockData) {
    return _$disableFlockAsyncAction.run(() => super.disableFlock(flockData));
  }

  final _$restoreFlockAsyncAction = AsyncAction('restoreFlock');

  @override
  Future<Flock> restoreFlock(Flock flockData) {
    return _$restoreFlockAsyncAction.run(() => super.restoreFlock(flockData));
  }

  final _$FlocksStoreBaseActionController =
      ActionController(name: 'FlocksStoreBase');

  @override
  List<Flock> searchFlockById(String queryString) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction();
    try {
      return super.searchFlockById(queryString);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockCount(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction();
    try {
      return super.todayFlockCount(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockFirst(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction();
    try {
      return super.todayFlockFirst(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int todayFlockLast(DateTime date) {
    final _$actionInfo = _$FlocksStoreBaseActionController.startAction();
    try {
      return super.todayFlockLast(date);
    } finally {
      _$FlocksStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
