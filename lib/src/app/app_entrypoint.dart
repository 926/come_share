import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart' as sembast;

import 'package:come_share/src/app/my_app.dart';
import 'package:come_share/src/providers/database.dart';
import 'package:come_share/src/providers/rpc/rpcs.dart';
import 'package:come_share/src/providers/services/services.dart';
import 'package:come_share/src/providers/stores.dart';

class ComeShareApp extends StatelessWidget {
  final sembast.Database database;

  ComeShareApp({@required this.database});

  @override
  Widget build(BuildContext context) {
    return ComeShareAppEntrypoint(
      database: database,
      child: MyApp(),
    );
  }
}

class ComeShareAppEntrypoint extends StatelessWidget {
  final Widget child;
  final sembast.Database database;

  ComeShareAppEntrypoint({@required this.child, @required this.database});

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      database: database,
      child: RpcsProvider(
        child: ServicesProvider(
          child: StoresProvider(child: child, database: database),
        ),
      ),
    );
  }
}
