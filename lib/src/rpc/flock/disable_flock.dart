import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class DisableFlockRpc implements EndpointBase<Flock, Flock> {
  final sembast.Database _database;
  var store = sembast.StoreRef<String, List>.main();

  DisableFlockRpc(this._database);

  @override
  Future<Flock> request(Flock data) async {
    final flocks = (await store.record('flocks').get(_database) ?? [])
        .map((item) => Flock.fromJson((item as Map)?.cast<String, dynamic>()))
        .toList();
    final soonToBeDisabledFlock = Flock(
      id: data.id,
      axeUuid: data?.axeUuid ?? '0',
      items: data.items,
      comment: data.comment,
      received: data.received,
      date: data.date,
      creationDate: data.creationDate,
      flockType: data.flockType,
      herderId: data.herderId,
      status: false,
      statusUpdateDate: DateTime.now(),
    );

    flocks[soonToBeDisabledFlock.id] = soonToBeDisabledFlock;
    var flockRecord = store.record('flocks');
    await flockRecord.put(_database, flocks.map((f) => f.toJson()).toList());
    //await _database.put(flocks.map((flock) => flock.toJson()).toList(), 'flocks');

    return soonToBeDisabledFlock;
  }
}
