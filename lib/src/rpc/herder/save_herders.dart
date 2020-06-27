import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class SaveAllHerdersRpc implements EndpointBase<void, List<Herder>> {
  final sembast.Database _database;

  SaveAllHerdersRpc(this._database);

  @override
  Future<void> request(List<Herder> herders) async {
    await _database.put(
        herders.map((herder) => herder.toJson()).toList(), 'herders');
  }
}
