import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class GetHerdersRpc implements EndpointBase<List<Herder>, void> {
  final sembast.Database _database;

  GetHerdersRpc(this._database);

  Future<List<Herder>> request(void _) async {
    final data = (await _database.get('herders') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>();
    return data.map((json) => Herder.fromJson(json)).toList();
  }
}
