import 'package:mobx/mobx.dart';
import 'package:putu_putu/src/models/item.dart';
import 'package:putu_putu/src/models/lot.dart';
import 'package:putu_putu/src/models/herder.dart';
import 'package:putu_putu/src/stores/commodities.dart';

part 'cart.g.dart';

class CartStore = CartStoreBase with _$CartStore;

abstract class CartStoreBase with Store {
  final CommoditiesStore _commoditiesStore;

  @observable
  List<Item> items;

  @observable
  Herder herder;

  @observable
  String comment;

  // if users select a big quantity, they cannot add +1 lot with onTap in this Article
  // consider rework to get item.quantity for both
  @observable
  List<Lot> listBigQuantityOnForLot;

  @computed
  int get numberOfItem =>
      items.fold(0, (value, item) => value + item.quantity).round();

  @computed
  double get qt => items.fold(0.0, (value, item) => value + item.quantity);

  CartStoreBase(this._commoditiesStore) {
    items = <Item>[];
    listBigQuantityOnForLot = [];
  }

  @action
  void setHerder(Herder newHerder) {
    herder = newHerder;
  }

  @action
  void setComment(String newcomment) {
    comment = newcomment;
  }

  @action
  void addLot(Lot lot, double lotQuantity) {
    final _newItems = <Item>[];
    final _commodity = _commoditiesStore.commodities
        .firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots
        .firstWhere((l) => l.id == lot.id); // use lot in commodityStore

    if (!items.any((item) => // first click on item
        item.lot.commodityId == _lot.commodityId && item.lot.id == _lot.id)) {
      _newItems.add(Item(lot, lotQuantity)); // adding the new lot/item

      items.forEach((item) {
        _newItems.add(item); // adding all the previous ones
      });
    } else {
      items.forEach((item) {
        if (item.lot.id == _lot.id &&
            item.lot.commodityId == _lot.commodityId) {
          _newItems.add(Item(item.lot, item.quantity + lotQuantity));
        } else {
          _newItems.add(item);
        }
      });
    }
    items = _newItems;
    //print(_newItems.length);
    //print(_newItems.last.quantity);
    print(items.length);
    print(items.last.quantity);
    print(items.last.lot.id);
    print(items.last.lot.commodityId);
    print('qt $qt');
  }

  @action
  void removeLot(Lot lot) {
    final _items = <Item>[];
    for (final item in items) {
      if (item.lot.id == lot.id && item.lot.commodityId == lot.commodityId) {
        continue; // stays in the if and no adding
      }
      _items.add(item);
    }
    items = _items;
  }

  @action
  void clearItems() {
    items = <Item>[];
  }

  @action
  void clearComment() {
    comment = null;
  }

  @action
  void clearHerder() {
    herder = null;
  }

  @action
  void bigQuantityOnForLot(Lot lot) {
    listBigQuantityOnForLot.add(lot);
  }

  @action
  void bigQuantityOffForLot(Lot lot) {
    listBigQuantityOnForLot.remove(lot);
  }

  @action
  void removeAllBigQuantities() {
    listBigQuantityOnForLot = [];
  }
}
