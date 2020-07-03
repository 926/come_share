import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

// this erases when importing
class SaveAllCommoditiesRpc implements EndpointBase<void, List<Commodity>> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  SaveAllCommoditiesRpc(this._database);

  @override
  Future<void> request(List<Commodity> commodities) async {
    var tt = store.record('commodities');
    await tt.put(_database, commodities.map((c) => c.toJson()).toList());

    //_database.put(commodities.map((c) => c.toJson()).toList(), 'commodities');
  }
}
