import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/collector.dart';
import 'package:come_share/src/servives/collector.dart';

part 'collector.g.dart';

class CollectorStore = CollectorStoreBase with _$CollectorStore;

abstract class CollectorStoreBase with Store {
  final CollectorService _collectorService;

  @observable
  bool initialLoading;

  @observable
  List<Collector> collector;

  CollectorStoreBase(this._collectorService) {
    initialLoading = true;
    collector = ObservableList<Collector>();
  }

  @action
  Future<void> loadTasks() async {
    final _collectors = await _collectorService.getCollectorRpc.request(null);
    collector = ObservableList.of(_collectors);
    initialLoading = false;
  }

  @action
  Future<void> init() async {
    await loadTasks();
    initialLoading = false;
  }

/* @action
  Future<List<Collector>> importCollectorFromMongo(List<Collector> _collector) async {
    collector = _collector;
    await _collectorService.saveCollectorRpc.request(_collector);
    return collector;
  } */
}
