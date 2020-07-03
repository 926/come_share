import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class RestoreFlockRpc implements EndpointBase<Flock, Flock> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  RestoreFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await store.record('flocks').get(_database) ?? [])
        .map((item) => Flock.fromJson((item as Map)?.cast<String, dynamic>()))
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

    //await _database.put(flocks.map((flock) => flock.toJson()).toList(), 'flocks');
    var flockRecord = store.record('flocks');
    await flockRecord.put(_database, flocks.map((f) => f.toJson()).toList());
    return soonToBeRestoredFlock;
  }
}
