import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class GetCommoditiesRpc implements EndpointBase<List<Commodity>, void> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  GetCommoditiesRpc(this._database);

  @override
  Future<List<Commodity>> request(void data) async => (await store
              .record('commodities')
              .get(_database) ??
          [])
      .map((item) => Commodity.fromJson((item as Map)?.cast<String, dynamic>()))
      .toList();
}
