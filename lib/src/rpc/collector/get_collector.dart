import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/collector.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class GetCollectorRpc implements EndpointBase<List<Collector>, void> {
  final sembast.Database _database;

  GetCollectorRpc(this._database);

  Future<List<Collector>> request(void _) async {
    final data = (await _database.get('collector') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>();
    return data.map((json) => Collector.fromJson(json)).toList();
  }
}
