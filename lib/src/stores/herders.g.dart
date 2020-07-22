// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'herders.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HerdersStore on HerdersStoreBase, Store {
  final _$initialLoadingAtom = Atom(name: 'HerdersStoreBase.initialLoading');

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

  final _$herdersAtom = Atom(name: 'HerdersStoreBase.herders');

  @override
  ObservableList<Herder> get herders {
    _$herdersAtom.reportRead();
    return super.herders;
  }

  @override
  set herders(ObservableList<Herder> value) {
    _$herdersAtom.reportWrite(value, super.herders, () {
      super.herders = value;
    });
  }

  final _$initAsyncAction = AsyncAction('HerdersStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$loadTasksAsyncAction = AsyncAction('HerdersStoreBase.loadTasks');

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  final _$replaceAllHerdersAsyncAction =
      AsyncAction('HerdersStoreBase.replaceAllHerders');

  @override
  Future<ObservableList<Herder>> replaceAllHerders(List<Herder> _herders) {
    return _$replaceAllHerdersAsyncAction
        .run(() => super.replaceAllHerders(_herders));
  }

  final _$deleteAllHerdersAsyncAction =
      AsyncAction('HerdersStoreBase.deleteAllHerders');

  @override
  Future<void> deleteAllHerders() {
    return _$deleteAllHerdersAsyncAction.run(() => super.deleteAllHerders());
  }

  final _$addHerdersJsonAsyncAction =
      AsyncAction('HerdersStoreBase.addHerdersJson');

  @override
  Future<ObservableList<Herder>> addHerdersJson(String json) {
    return _$addHerdersJsonAsyncAction.run(() => super.addHerdersJson(json));
  }

  final _$HerdersStoreBaseActionController =
      ActionController(name: 'HerdersStoreBase');

  @override
  List<Herder> searchHerderByQr(String queryString) {
    final _$actionInfo = _$HerdersStoreBaseActionController.startAction(
        name: 'HerdersStoreBase.searchHerderByQr');
    try {
      return super.searchHerderByQr(queryString);
    } finally {
      _$HerdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initialLoading: ${initialLoading},
herders: ${herders}
    ''';
  }
}
