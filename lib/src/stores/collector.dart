import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/collector.dart';
import 'package:come_share/src/servives/collector.dart';
import 'package:sembast/sembast.dart' as sembast;

part 'collector.g.dart';

class CollectorStore = CollectorStoreBase with _$CollectorStore;

abstract class CollectorStoreBase with Store {
  final CollectorService _collectorService;

  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  bool initialLoading;

  @observable
  Collector collector;

  CollectorStoreBase(this._database, this._collectorService) {
    initialLoading = true;
    collector = Collector();
  }

  final _collectorDbStore = sembast.intMapStoreFactory.store("collector");

  @action
  Future<void> loadTasks() async {
    var _collector = await _collectorDbStore.find(_database);
    collector =
        _collector.map((e) => Collector.fromJson(e.value)).toList().first;
    initialLoading = false;
  }

  @action
  Future<void> init() async {
    await loadTasks();
    initialLoading = false;
  }

  /// Create a herder from a snapshot, setting its content and key
  Collector collectorFromSnapshot(
      sembast.RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Collector.fromJson(snapshot.value)..id = snapshot.key;
    }
    return null;
  }

  Future<Collector> getCollector(int key) async {
    var snapshot = await _collectorDbStore.record(key).getSnapshot(_database);
    return collectorFromSnapshot(snapshot);
  }

  @action
  Future<Collector> updateCollector(Collector _collector) async {
    final coolerThanWaterCollector = await _collectorDbStore
        .record(_collector.id)
        .put(_database, _collector.toJson());
    collector = Collector.fromJson(coolerThanWaterCollector);
    return collector;
  }

  @action
  Future<Collector> importCollectorFromJson(Collector _collector) async {
    final chicCollector = await updateCollector(_collector);
    collector = chicCollector;
    return collector;
  }
}
