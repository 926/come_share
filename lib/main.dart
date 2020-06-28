import 'dart:io';
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
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('fr');
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String path = join(appDocDir.path, 'cs.db');
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database database = await dbFactory.openDatabase(path, version: 1);
  DateTime now = DateTime.now();

  /* List<dynamic> passwords = await database.get('passwords') ?? [];
  if (passwords.isEmpty) {
    passwords = [
      {'id': '0', 'name': 'default', 'password': '2020'},
    ];
    await database.put(passwords, 'passwords');
  }
  if (passwords.isEmpty) {
    final jsonPasswords =
        passwords.map((passwords) => passwords.toJson()).toList();

    await database.put(jsonPasswords, 'passwords');
  }
 */
  // this is used for unknown
  List<dynamic> herders = await database.get('herders') ?? [];
  if (herders.isEmpty) {
    final _herders = [
      Herder(
          id: 0,
          bidon: 0,
          firstName: 'inconnu',
          lastName: '',
          avatar: '',
          qrcode: '',
          date: now,
          updateDate: now,
          status: true,
          statusUpdateDate: now),
      Herder(
          id: 1,
          bidon: 1,
          firstName: 'test',
          lastName: '',
          avatar: '',
          qrcode: 'kossam_sde_00029',
          date: now,
          updateDate: now,
          status: true,
          statusUpdateDate: now),
    ];
    await database.put(_herders.map((h) => h.toJson()).toList(), 'herders');
  }

  List<dynamic> collectors = await database.get('collectors') ?? [];
  if (collectors.isEmpty) {
    final _collectors = [
      Collector(
        id: 0,
        uuid: '0',
        firstName: 'Bootsy',
        lastName: 'Collins',
        tel: '123456',
        mail: '1',
        address: '1',
        lat: '1',
        status: true,
        statusUpdateDate: null,
        serverStatus: false,
        serverStatusUpdateDate: null,
        isProd: false,
        isLocked: false,
        date: now,
        updateDate: now,
      ),
    ];
    await database.put(
        _collectors.map((h) => h.toJson()).toList(), 'collectors');
  }
  List<dynamic> commodities = await database.get('commodities') ?? [];
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
        name: 'Milk',
        weight: 1,
        photo: 'milk.jpg',
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
    await database.put(
        _commodities.map((c) => c.toJson()).toList(), 'commodities');
  }

  runApp(ComeShareApp(database: database));
}
