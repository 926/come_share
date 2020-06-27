import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/item.dart';
import 'package:come_share/src/models/lot.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/stores/commodities.dart';

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
  void addLot(Lot lot, double qt) {
    final _newItems = <Item>[];
    final _commodity = _commoditiesStore.commodities
        .firstWhere((commodity) => commodity.id == lot.commodityId);
    final _lot = _commodity.lots
        .firstWhere((l) => l.id == lot.id); // use lot in commodityStore

    if (!items.any((item) => // this was never added here
        item.lot.commodityId == _lot.commodityId && item.lot.id == _lot.id)) {
      _newItems.add(Item(lot, qt)); // adding the new lot/item

      items.forEach((item) {
        _newItems.add(item); // adding all the previous ones
      });
    } else {
      items.forEach((item) {
        if (item.lot.id == _lot.id &&
            item.lot.commodityId == _lot.commodityId) {
          _newItems.add(Item(item.lot, item.quantity + qt));
        } else {
          _newItems.add(item);
        }
      });
    }
    items = _newItems;
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
