// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CollectorStore on CollectorStoreBase, Store {
  final _$initialLoadingAtom = Atom(name: 'CollectorStoreBase.initialLoading');

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

  final _$collectorAtom = Atom(name: 'CollectorStoreBase.collector');

  @override
  Collector get collector {
    _$collectorAtom.reportRead();
    return super.collector;
  }

  @override
  set collector(Collector value) {
    _$collectorAtom.reportWrite(value, super.collector, () {
      super.collector = value;
    });
  }

  final _$initAsyncAction = AsyncAction('CollectorStoreBase.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$updateCollectorAsyncAction =
      AsyncAction('CollectorStoreBase.updateCollector');

  @override
  Future<Collector> updateCollector(Collector _collector) {
    return _$updateCollectorAsyncAction
        .run(() => super.updateCollector(_collector));
  }

  final _$importCollectorFromJsonAsyncAction =
      AsyncAction('CollectorStoreBase.importCollectorFromJson');

  @override
  Future<Collector> importCollectorFromJson(Collector _collector) {
    return _$importCollectorFromJsonAsyncAction
        .run(() => super.importCollectorFromJson(_collector));
  }

  @override
  String toString() {
    return '''
initialLoading: ${initialLoading},
collector: ${collector}
    ''';
  }
}
