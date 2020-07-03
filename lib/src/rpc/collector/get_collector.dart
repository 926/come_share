import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/collector.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class GetCollectorRpc implements EndpointBase<List<Collector>, void> {
  var store = sembast.StoreRef<String, List<dynamic>>.main();
  final sembast.Database _database;

  GetCollectorRpc(this._database);

  @override
  Future<List<Collector>> request(void _) async => (await store
              .record('collector')
              .get(_database) ??
          [])
      .map((item) => Collector.fromJson((item as Map)?.cast<String, dynamic>()))
      .toList();
}
