import 'package:sembast/sembast.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

// this erases when importing
class SaveAllCommoditiesRpc implements EndpointBase<void, List<Commodity>> {
  final Database _database;

  SaveAllCommoditiesRpc(this._database);

  @override
  Future<void> request(List<Commodity> products) async {
    await _database.put(
        products.map((product) => product.toJson()).toList(), 'products');
  }
}
