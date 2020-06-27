import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class DeleteForeverHerderRpc implements EndpointBase<void, Herder> {
  final sembast.Database _database;

  DeleteForeverHerderRpc(this._database);

  @override
  Future<void> request(Herder data) async {
    final herders = (await _database.get('herders') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    var herderIndex = herders.firstWhere((h) => h.id == data.id, orElse: null);
    herders.remove(herderIndex);

    await _database.put(
        herders.map((herder) => herder.toJson()).toList(), 'herders');
  }
}
