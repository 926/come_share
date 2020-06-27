// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'herders.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HerdersStore on HerdersStoreBase, Store {
  final _$initialLoadingAtom = Atom(name: 'HerdersStoreBase.initialLoading');

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

  final _$herdersAtom = Atom(name: 'HerdersStoreBase.herders');

  @override
  ObservableList<Herder> get herders {
    _$herdersAtom.context.enforceReadPolicy(_$herdersAtom);
    _$herdersAtom.reportObserved();
    return super.herders;
  }

  @override
  set herders(ObservableList<Herder> value) {
    _$herdersAtom.context.conditionallyRunInAction(() {
      super.herders = value;
      _$herdersAtom.reportChanged();
    }, _$herdersAtom, name: '${_$herdersAtom.name}_set');
  }

  final _$saveAllHerdersAsyncAction = AsyncAction('saveAllHerders');

  @override
  Future<List<Herder>> saveAllHerders(List<Herder> _herders) {
    return _$saveAllHerdersAsyncAction
        .run(() => super.saveAllHerders(_herders));
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

  final _$createHerderAsyncAction = AsyncAction('createHerder');

  @override
  Future<Herder> createHerder(Herder herderData) {
    return _$createHerderAsyncAction.run(() => super.createHerder(herderData));
  }

  final _$updateHerderAsyncAction = AsyncAction('updateHerder');

  @override
  Future<Herder> updateHerder(Herder herder) {
    return _$updateHerderAsyncAction.run(() => super.updateHerder(herder));
  }

  final _$disableHerderAsyncAction = AsyncAction('disableHerder');

  @override
  Future<Herder> disableHerder(Herder herderdata) {
    return _$disableHerderAsyncAction
        .run(() => super.disableHerder(herderdata));
  }

  final _$restoreHerderAsyncAction = AsyncAction('restoreHerder');

  @override
  Future<Herder> restoreHerder(Herder herderData) {
    return _$restoreHerderAsyncAction
        .run(() => super.restoreHerder(herderData));
  }

  final _$deleteForeverHerderAsyncAction = AsyncAction('deleteForeverHerder');

  @override
  Future<ObservableList<Herder>> deleteForeverHerder(Herder herder) {
    return _$deleteForeverHerderAsyncAction
        .run(() => super.deleteForeverHerder(herder));
  }

  final _$deleteAllHerdersAsyncAction = AsyncAction('deleteAllHerders');

  @override
  Future<ObservableList<Herder>> deleteAllHerders(List<Herder> theseHerders) {
    return _$deleteAllHerdersAsyncAction
        .run(() => super.deleteAllHerders(theseHerders));
  }

  final _$importHerdersAsyncAction = AsyncAction('importHerders');

  @override
  Future<ObservableList<Herder>> importHerders(String json) {
    return _$importHerdersAsyncAction.run(() => super.importHerders(json));
  }

  final _$importHerdersFromMongoAsyncAction =
      AsyncAction('importHerdersFromMongo');

  @override
  Future<ObservableList<Herder>> importHerdersFromMongo(List<Herder> _herders) {
    return _$importHerdersFromMongoAsyncAction
        .run(() => super.importHerdersFromMongo(_herders));
  }

  final _$HerdersStoreBaseActionController =
      ActionController(name: 'HerdersStoreBase');

  @override
  List<Herder> searchHerderByQr(String queryString) {
    final _$actionInfo = _$HerdersStoreBaseActionController.startAction();
    try {
      return super.searchHerderByQr(queryString);
    } finally {
      _$HerdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
