import 'package:sembast/sembast.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class SaveAllFlocksRpc implements EndpointBase<void, List<Flock>> {
  final Database _database;

  SaveAllFlocksRpc(this._database);

  @override
  Future<void> request(List<Flock> flocks) async {
    await _database.put(
        flocks.map((flock) => flock.toJson()).toList(), 'flocks');
  }
}
