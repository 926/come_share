import 'package:sembast/sembast.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/rpc/endpoint_base.dart';

class CreateHerderRpc implements EndpointBase<Herder, Herder> {
  final Database _database;

  CreateHerderRpc(this._database);

  @override
  Future<Herder> request(Herder data) async {
    final _herders = (await _database.get('herders') as List ?? [])
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();

    final _herder = Herder(
      id: _herders.fold<int>(0, (max, e) => e.id > max ? e.id : max) + 1,
      bidon: data.bidon,
      firstName: data.firstName,
      lastName: data.lastName,
      tel: data?.tel,
      mail: data?.mail,
      address: data?.address,
      avatar: data.avatar,
      qrcode: data.qrcode,
      overdraft: data.overdraft,
      updateDate: data.updateDate,
      status: true,
      statusUpdateDate: DateTime.now(),
      milkMonthQuota: data.milkMonthQuota,
    );

    _herders.add(_herder);
    await _database.put(
        _herders.map((herder) => herder.toJson()).toList(), 'herders');
    return _herder;
  }
}
