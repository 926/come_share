import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/collector.dart';
import 'package:sembast/sembast.dart' as sembast;

part 'collector.g.dart';

class CollectorStore = CollectorStoreBase with _$CollectorStore;

abstract class CollectorStoreBase with Store {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  @observable
  bool initialLoading;

  @observable
  Collector collector;

  CollectorStoreBase(this._database) {
    initialLoading = true;
    collector = Collector();
  }

  final _collectorDbStore = sembast.intMapStoreFactory.store("collector");

  @action
  Future<void> init() async {
    final collectors = await getAllCollectors();
    collector = collectors.first;
    initialLoading = false;
  }

  Future<List<Collector>> getAllCollectors() async {
    var recordSnapshot = await _collectorDbStore.find(_database);
    return recordSnapshot.map((e) => Collector.fromJson(e.value)).toList();
  }

  Future<Collector> getCollector(int key) async {
    var snapshot = await _collectorDbStore.record(key).getSnapshot(_database);
    return collectorFromSnapshot(snapshot);
  }

  /// Create a herder from a snapshot, setting its content and key
  Collector collectorFromSnapshot(
      sembast.RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    if (snapshot != null) {
      return Collector.fromJson(snapshot.value)..id = snapshot.key;
    }
    return null;
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
