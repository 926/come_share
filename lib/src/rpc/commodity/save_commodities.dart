import 'package:sembast/sembast.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

// this erases when importing
class SaveAllCommoditiesRpc implements EndpointBase<void, List<Commodity>> {
  final Database _database;

  SaveAllCommoditiesRpc(this._database);

  @override
  Future<void> request(List<Commodity> commodities) async {
    await _database.put(
        commodities.map((c) => c.toJson()).toList(), 'commodities');
  }
}