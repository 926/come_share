import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class GetCommoditiesRpc implements EndpointBase<List<Commodity>, void> {
  final sembast.Database _database;

  GetCommoditiesRpc(this._database);

  @override
  Future<List<Commodity>> request(void data) async =>
      (await _database.get('commodities') as List ?? [])
          .cast<Map>()
          .cast<Map<String, dynamic>>()
          .map((c) => Commodity.fromJson(c))
          .toList();
}
