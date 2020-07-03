import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class GetFlocksRpc implements EndpointBase<List<Flock>, void> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  GetFlocksRpc(this._database);

  @override
  Future<List<Flock>> request(void data) async =>
      (await store.record('flocks').get(_database) ?? [])
          .map((item) => Flock.fromJson((item as Map)?.cast<String, dynamic>()))
          .toList();

  /* (await _database.get('flocks') as List ?? [])
          .cast<Map>()
          .cast<Map<String, dynamic>>()
          .map((ticket) => Flock.fromJson(ticket))
          .toList(); */
}
