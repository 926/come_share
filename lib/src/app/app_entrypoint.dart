import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart' as sembast;

import 'package:come_share/src/app/my_app.dart';
import 'package:come_share/src/providers/database.dart';
import 'package:come_share/src/providers/stores.dart';

class ComeShareApp extends StatelessWidget {
  final sembast.Database database;

  ComeShareApp({@required this.database});

  @override
  Widget build(BuildContext context) {
    return ComeShareAppEntrypoint(
      database: database,
      materialAppChild: MyApp(),
    );
  }
}

class ComeShareAppEntrypoint extends StatelessWidget {
  final Widget materialAppChild;
  final sembast.Database database;

  ComeShareAppEntrypoint(
      {@required this.materialAppChild, @required this.database});

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      database: database,
      child: StoresProvider(child: materialAppChild, database: database),
    );
  }
}
