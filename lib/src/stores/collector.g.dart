// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CollectorStore on CollectorStoreBase, Store {
  final _$initialLoadingAtom = Atom(name: 'CollectorStoreBase.initialLoading');

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

  final _$collectorAtom = Atom(name: 'CollectorStoreBase.collector');

  @override
  List<Collector> get collector {
    _$collectorAtom.context.enforceReadPolicy(_$collectorAtom);
    _$collectorAtom.reportObserved();
    return super.collector;
  }

  @override
  set collector(List<Collector> value) {
    _$collectorAtom.context.conditionallyRunInAction(() {
      super.collector = value;
      _$collectorAtom.reportChanged();
    }, _$collectorAtom, name: '${_$collectorAtom.name}_set');
  }

  final _$loadTasksAsyncAction = AsyncAction('loadTasks');

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }
}