// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on CartStoreBase, Store {
  Computed<int> _$numberOfItemComputed;

  @override
  int get numberOfItem =>
      (_$numberOfItemComputed ??= Computed<int>(() => super.numberOfItem))
          .value;

  final _$itemsAtom = Atom(name: 'CartStoreBase.items');

  @override
  List<Item> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(List<Item> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }

  final _$herderAtom = Atom(name: 'CartStoreBase.herder');

  @override
  Herder get herder {
    _$herderAtom.context.enforceReadPolicy(_$herderAtom);
    _$herderAtom.reportObserved();
    return super.herder;
  }

  @override
  set herder(Herder value) {
    _$herderAtom.context.conditionallyRunInAction(() {
      super.herder = value;
      _$herderAtom.reportChanged();
    }, _$herderAtom, name: '${_$herderAtom.name}_set');
  }

  final _$commentAtom = Atom(name: 'CartStoreBase.comment');

  @override
  String get comment {
    _$commentAtom.context.enforceReadPolicy(_$commentAtom);
    _$commentAtom.reportObserved();
    return super.comment;
  }

  @override
  set comment(String value) {
    _$commentAtom.context.conditionallyRunInAction(() {
      super.comment = value;
      _$commentAtom.reportChanged();
    }, _$commentAtom, name: '${_$commentAtom.name}_set');
  }

  final _$listBigQuantityOnForLotAtom =
      Atom(name: 'CartStoreBase.listBigQuantityOnForLot');

  @override
  List<Lot> get listBigQuantityOnForLot {
    _$listBigQuantityOnForLotAtom.context
        .enforceReadPolicy(_$listBigQuantityOnForLotAtom);
    _$listBigQuantityOnForLotAtom.reportObserved();
    return super.listBigQuantityOnForLot;
  }

  @override
  set listBigQuantityOnForLot(List<Lot> value) {
    _$listBigQuantityOnForLotAtom.context.conditionallyRunInAction(() {
      super.listBigQuantityOnForLot = value;
      _$listBigQuantityOnForLotAtom.reportChanged();
    }, _$listBigQuantityOnForLotAtom,
        name: '${_$listBigQuantityOnForLotAtom.name}_set');
  }

  final _$CartStoreBaseActionController =
      ActionController(name: 'CartStoreBase');

  @override
  void setHerder(Herder newHerder) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.setHerder(newHerder);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComment(String newcomment) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.setComment(newcomment);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLot(Lot lot, double qt) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.addLot(lot, qt);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.removeLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearItems() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.clearItems();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearComment() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.clearComment();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearHerder() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.clearHerder();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bigQuantityOnForLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.bigQuantityOnForLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bigQuantityOffForLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.bigQuantityOffForLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAllBigQuantities() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction();
    try {
      return super.removeAllBigQuantities();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }
}
