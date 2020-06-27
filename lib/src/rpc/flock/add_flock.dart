import 'package:sembast/sembast.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class AddFlockRpc implements EndpointBase<Flock, Flock> {
  final Database _database;

  AddFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await _database.get('flocks') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    final flock = Flock(
        id: flocks.isEmpty
            ? 0
            : flocks.fold<int>(0, (max, e) => e.id > max ? e.id : max) + 1,
        axeUuid: data?.axeUuid ?? '0',
        items: data.items,
        date: data.date,
        received: data.received,
        comment: data.comment,
        flockType: data.flockType,
        herderId: data.herderId,
        status: data.status,
        statusUpdateDate: data.statusUpdateDate,
        creationDate: data.creationDate);
    flocks.add(flock);
    await _database.put(
        flocks.map((flock) => flock.toJson()).toList(), 'flocks');
    return flock;
  }
}
