import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:come_share/src/models/collector.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/lot.dart';
import 'package:come_share/src/app/app_entrypoint.dart';
// import 'package:tekartik_app_platform/app_platform.dart';
// import 'package:tekartik_app_flutter_sembast/sembast.dart';
// import 'package:tekartik_common_utils/common_utils_import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('fr');
  DateTime now = DateTime.now();

  sembast.Database _database;
  if (kIsWeb) {
    var factory = databaseFactoryWeb;
    _database = await factory.openDatabase('app.db');
  } else {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, 'cs.db');
    sembast.DatabaseFactory dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(path, version: 1);
  }
  // ? use this for db seetings only
  //var store = sembast.StoreRef<String, List<dynamic>>.main();

  final _herdersDbStore = sembast.intMapStoreFactory.store('herders');
  final hiddenHerders = await _herdersDbStore.find(_database);

  if (hiddenHerders.isEmpty) {
    final _herders = [
      Herder(
          id: 0,
          bidon: 0,
          firstName: 'inconnu',
          lastName: '',
          tel: '',
          mail: '',
          address: '',
          avatar: '',
          qrcode: '',
          date: now,
          updateDate: now,
          status: true,
          statusUpdateDate: now),
      Herder(
          id: 1,
          bidon: 1,
          firstName: 'Etta',
          lastName: 'James',
          tel: '987654321',
          mail: 'etta@diva.org',
          address: 'paradise',
          avatar: '',
          qrcode: 'kossam_sde_00029',
          date: now,
          updateDate: now,
          status: true,
          statusUpdateDate: now),
    ];
    //await database.put(_herders.map((h) => h.toJson()).toList(), 'herders');
    await _herdersDbStore.addAll(
        _database, _herders.map((h) => h.toJson()).toList());
  }

  final _collectorDbStore = sembast.intMapStoreFactory.store('collector');
  final hiddenCollector = await _collectorDbStore.find(_database);

  if (hiddenCollector.isEmpty) {
    final _collector = [
      Collector(
        id: 0,
        uuid: '0',
        companyPhoto: 'ldb_logo.png',
        collectorPhoto: 'biker.png',
        firstName: 'Jorja',
        lastName: 'Smith',
        tel: '123456789',
        mail: 'be_honest@dancetillyoudrop.com',
        address: '3rd Grooving Boulevard',
        lat: '1',
        long: '-1',
        status: true,
        statusUpdateDate: now,
        serverStatus: false,
        serverStatusUpdateDate: now,
        isProd: true,
        isLocked: false,
        date: now,
        updateDate: now,
      ),
    ];
    await _collectorDbStore.addAll(
        _database, _collector.map((c) => c.toJson()).toList());
  }

  final _commoditiesDbStore = sembast.intMapStoreFactory.store('commodities');
  final hiddenCommodities = await _commoditiesDbStore.find(_database);
  if (hiddenCommodities.isEmpty) {
    final _commodities = [
      Commodity(
        companyUuid: '0',
        id: 0,
        name: '*',
        weight: 1,
        photo: '',
        status: true,
        statusUpdateDate: now,
        date: now,
        updateDate: now,
        lots: [
          Lot(
              companyUuid: '0',
              commodityId: 0,
              id: 1,
              comment: '',
              isDefault: true,
              lotDate: now)
        ],
      ),
      Commodity(
        companyUuid: '0',
        id: 1,
        name: 'Lait l.',
        weight: 1,
        photo: 'milk-logo.png',
        status: true,
        statusUpdateDate: now,
        date: now,
        updateDate: now,
        lots: [
          Lot(
              companyUuid: '0',
              commodityId: 1,
              id: 1,
              comment: '',
              isDefault: true,
              lotDate: now),
        ],
      ),
    ];

    await _commoditiesDbStore.addAll(
        _database, _commodities.map((c) => c.toJson()).toList());
  }

  runApp(ComeShareApp(database: _database));
}
