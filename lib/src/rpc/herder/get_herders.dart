import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class GetHerdersRpc implements EndpointBase<List<Herder>, void> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  GetHerdersRpc(this._database);

  @override
  Future<List<Herder>> request(void _) async =>
      (await store.record('herders').get(_database) ?? [])
          .map(
              (item) => Herder.fromJson((item as Map)?.cast<String, dynamic>()))
          .toList();
}
