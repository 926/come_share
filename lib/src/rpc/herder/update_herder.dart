import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class UpdateHerderRpc implements EndpointBase<Herder, Herder> {
  final sembast.Database _database;

  UpdateHerderRpc(this._database);

  @override
  Future<Herder> request(Herder data) async {
    final herders = (await _database.get('herders') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    final soonTobeUpdatedHerder = Herder(
      id: data
          .id, // will need to change this to getting the last herder in the list of all herders and assigning a +1 id
      bidon: data.bidon,
      firstName: data.firstName,
      lastName: data.lastName,
      tel: data?.tel,
      mail: data?.mail,
      address: data?.address,
      qrcode: data.qrcode,
      overdraft: data.overdraft,
      updateDate: DateTime.now(),
      status: data.status,
      statusUpdateDate: data.statusUpdateDate,
      milkMonthQuota: data.milkMonthQuota,
    );
    var herderIndex = soonTobeUpdatedHerder.id;
    herders[herderIndex] = soonTobeUpdatedHerder;

    await _database.put(
        herders.map((herder) => herder.toJson()).toList(), 'herders');
    return soonTobeUpdatedHerder;
  }
}

// final _herder =
