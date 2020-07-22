// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on CartStoreBase, Store {
  Computed<int> _$numberOfItemComputed;

  @override
  int get numberOfItem =>
      (_$numberOfItemComputed ??= Computed<int>(() => super.numberOfItem,
              name: 'CartStoreBase.numberOfItem'))
          .value;
  Computed<double> _$qtComputed;

  @override
  double get qt => (_$qtComputed ??=
          Computed<double>(() => super.qt, name: 'CartStoreBase.qt'))
      .value;

  final _$itemsAtom = Atom(name: 'CartStoreBase.items');

  @override
  List<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$herderAtom = Atom(name: 'CartStoreBase.herder');

  @override
  Herder get herder {
    _$herderAtom.reportRead();
    return super.herder;
  }

  @override
  set herder(Herder value) {
    _$herderAtom.reportWrite(value, super.herder, () {
      super.herder = value;
    });
  }

  final _$commentAtom = Atom(name: 'CartStoreBase.comment');

  @override
  String get comment {
    _$commentAtom.reportRead();
    return super.comment;
  }

  @override
  set comment(String value) {
    _$commentAtom.reportWrite(value, super.comment, () {
      super.comment = value;
    });
  }

  final _$listBigQuantityOnForLotAtom =
      Atom(name: 'CartStoreBase.listBigQuantityOnForLot');

  @override
  List<Lot> get listBigQuantityOnForLot {
    _$listBigQuantityOnForLotAtom.reportRead();
    return super.listBigQuantityOnForLot;
  }

  @override
  set listBigQuantityOnForLot(List<Lot> value) {
    _$listBigQuantityOnForLotAtom
        .reportWrite(value, super.listBigQuantityOnForLot, () {
      super.listBigQuantityOnForLot = value;
    });
  }

  final _$CartStoreBaseActionController =
      ActionController(name: 'CartStoreBase');

  @override
  void setHerder(Herder newHerder) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.setHerder');
    try {
      return super.setHerder(newHerder);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComment(String newcomment) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.setComment');
    try {
      return super.setComment(newcomment);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLot(Lot lot, double lotQuantity) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.addLot');
    try {
      return super.addLot(lot, lotQuantity);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeLot');
    try {
      return super.removeLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearItems() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.clearItems');
    try {
      return super.clearItems();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearComment() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.clearComment');
    try {
      return super.clearComment();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearHerder() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.clearHerder');
    try {
      return super.clearHerder();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bigQuantityOnForLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.bigQuantityOnForLot');
    try {
      return super.bigQuantityOnForLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bigQuantityOffForLot(Lot lot) {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.bigQuantityOffForLot');
    try {
      return super.bigQuantityOffForLot(lot);
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAllBigQuantities() {
    final _$actionInfo = _$CartStoreBaseActionController.startAction(
        name: 'CartStoreBase.removeAllBigQuantities');
    try {
      return super.removeAllBigQuantities();
    } finally {
      _$CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
herder: ${herder},
comment: ${comment},
listBigQuantityOnForLot: ${listBigQuantityOnForLot},
numberOfItem: ${numberOfItem},
qt: ${qt}
    ''';
  }
}
