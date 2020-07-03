import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class SaveAllHerdersRpc implements EndpointBase<void, List<Herder>> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  SaveAllHerdersRpc(this._database);

  @override
  Future<void> request(List<Herder> herders) async {
    var herderRecord = store.record('herders');
    herderRecord.put(
        _database, herders.map((herder) => herder.toJson()).toList());
  }
}
