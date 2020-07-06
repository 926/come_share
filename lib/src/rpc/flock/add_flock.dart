import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class AddFlockRpc implements EndpointBase<Flock, Flock> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  AddFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await store.record('flocks').get(_database) ?? [])
        .map((item) => Flock.fromJson((item as Map)?.cast<String, dynamic>()))
        .toList();
    final flock = Flock(
        //id: flocks.isEmpty
        //    ? 0
        //    : flocks.fold<int>(0, (max, e) => e.id > max ? e.id : max) + 1,
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
    var flockRecord = store.record('flocks');
    await flockRecord.put(_database, flocks.map((f) => f.toJson()).toList());

    //await _database.put(flocks.map((flock) => flock.toJson()).toList(), 'flocks');
    return flock;
  }
}
