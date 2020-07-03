import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class SaveAllFlocksRpc implements EndpointBase<void, List<Flock>> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  SaveAllFlocksRpc(this._database);

  @override
  Future<void> request(List<Flock> flocks) async {
    var flockRecord = store.record('flocks');
    await flockRecord.put(_database, flocks.map((f) => f.toJson()).toList());

    //await _database.put(flocks.map((flock) => flock.toJson()).toList(), 'flocks');
  }
}
