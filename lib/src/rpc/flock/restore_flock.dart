import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class RestoreFlockRpc implements EndpointBase<Flock, Flock> {
  final sembast.Database _database;

  RestoreFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await _database.get('flocks') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    final soonToBeRestoredFlock = Flock(
        id: data.id,
        axeUuid: data?.axeUuid ?? '0',
        items: data.items,
        date: data.date,
        received: data.received,
        comment: data.comment,
        flockType: data.flockType,
        herderId: data.herderId,
        status: true,
        statusUpdateDate: DateTime.now(),
        creationDate: data.creationDate);
    var flockIndex = soonToBeRestoredFlock.id;
    flocks[flockIndex] = soonToBeRestoredFlock;

    await _database.put(
        flocks.map((flock) => flock.toJson()).toList(), 'flocks');
    return soonToBeRestoredFlock;
  }
}
