import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';
import 'package:sembast/sembast.dart' as sembast;

class RestoreHerderRpc implements EndpointBase<Herder, Herder> {
  final sembast.Database _database;

  RestoreHerderRpc(this._database);

  @override
  Future<Herder> request(Herder data) async {
    final herders = (await _database.get('herders') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    final soonTobeRestoredHerder = Herder(
      id: data.id,
      bidon: data.bidon,
      firstName: data.firstName,
      lastName: data.lastName,
      tel: data?.tel,
      mail: data?.mail,
      address: data?.address,
      qrcode: data.qrcode,
      overdraft: data.overdraft,
      updateDate: data.updateDate,
      status: true,
      statusUpdateDate: DateTime.now(),
      milkMonthQuota: data.milkMonthQuota,
    );
    var herderIndex = soonTobeRestoredHerder.id;
    herders[herderIndex] = soonTobeRestoredHerder;

    await _database.put(
        herders.map((herder) => herder.toJson()).toList(), 'herders');
    return soonTobeRestoredHerder;
  }
}

// final _herder = herders.firstWhere((h) => h.id == herder.id);
