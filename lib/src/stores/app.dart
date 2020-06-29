import 'package:come_share/src/stores/collector.dart';
import 'package:mobx/mobx.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/stores/commodities.dart';

part 'app.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  final FlocksStore _flocksStore;
  final HerdersStore _herdersStore;
  final CommoditiesStore _commoditiesStore;
  final CollectorStore _collectorStore;

  @observable
  bool initialLoading;

  AppStoreBase(this._flocksStore, this._herdersStore, this._commoditiesStore,
      this._collectorStore) {
    initialLoading = true;

    when(
      (reaction) {
        final value = !_flocksStore.initialLoading &&
            !_herdersStore.initialLoading &&
            !_commoditiesStore.initialLoading &&
            !_collectorStore.initialLoading;
        return value;
      },
      endInitialLoading,
    );

    //  init all store
    _flocksStore.init();
    _herdersStore.init();
    _commoditiesStore.init();
    _collectorStore.init();
  }

  @action
  void endInitialLoading() {
    initialLoading = false;
  }
}
