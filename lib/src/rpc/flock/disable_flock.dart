import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class DisableFlockRpc implements EndpointBase<Flock, Flock> {
  final sembast.Database _database;

  DisableFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await _database.get('flocks') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    final soonTobeDisabledFlock = Flock(
        id: data.id,
        axeUuid: data?.axeUuid ?? '0',
        items: data.items,
        date: data.date,
        received: data.received,
        comment: data.comment,
        flockType: data.flockType,
        herderId: data.herderId,
        status: false,
        statusUpdateDate: DateTime.now(),
        creationDate: data.creationDate);

    final flockIndex = soonTobeDisabledFlock.id;

    flocks[flockIndex] = soonTobeDisabledFlock;

    await _database.put(
        flocks.map((flock) => flock.toJson()).toList(), 'flocks');
    return soonTobeDisabledFlock;
  }
}
