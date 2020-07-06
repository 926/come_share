import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
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
  //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('fr');
  DateTime now = DateTime.now();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = join(appDocDir.path, 'cs.db');
  DatabaseFactory dbFactory = databaseFactoryIo;

  var store = StoreRef<String, List<dynamic>>.main();

  Database database = await dbFactory.openDatabase(path, version: 1);

  // this is the old version
  //List<dynamic> herders = await database.get('herders') ?? [];

  List<dynamic> herders = await store.record('herders').get(database) ?? [];

// TODO try below
// var herders = store.record('herders').exists(database);

  if (herders.isEmpty) {
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
    var herders = store.record('herders');
    await herders.put(database, _herders.map((h) => h.toJson()).toList());
  }

  List<dynamic> collector = await store.record('collector').get(database) ?? [];
  //List<dynamic> collectors = await database.get('collectors') ?? [];
  if (collector.isEmpty) {
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
    //await database.put(_collectors.map((h) => h.toJson()).toList(), 'collectors');
    var collector = store.record('collector');
    await collector.put(database, _collector.map((c) => c.toJson()).toList());
  }

  List<dynamic> commodities =
      await store.record('commodities').get(database) ?? [];
  //List<dynamic> commodities = await database.get('commodities') ?? [];
  if (commodities.isEmpty) {
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
              quantity: 0.0,
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
              quantity: 0.0,
              isDefault: true,
              lotDate: now),
        ],
      ),
    ];
    var commodities = store.record('commodities');

    await commodities.put(
        database, _commodities.map((c) => c.toJson()).toList());
    //await database.put(_commodities.map((c) => c.toJson()).toList(), 'commodities');
  }

  runApp(ComeShareApp(database: database));
}
