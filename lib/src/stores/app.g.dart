// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  final _$initialLoadingAtom = Atom(name: 'AppStoreBase.initialLoading');

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

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void endInitialLoading() {
    final _$actionInfo = _$AppStoreBaseActionController.startAction();
    try {
      return super.endInitialLoading();
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
