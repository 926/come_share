import 'package:putu_putu/src/routes/collector_detail.dart';
import 'package:putu_putu/src/routes/commodities/commodity_detail.dart';
import 'package:putu_putu/src/routes/commodities/lot_detail.dart';
import 'package:putu_putu/src/routes/export.dart';
import 'package:putu_putu/src/routes/flocks/flock_detail_frame.dart';
import 'package:putu_putu/src/routes/flocks/flocks.dart';
import 'package:putu_putu/src/routes/herders/herder_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:putu_putu/src/stores/app.dart';
import 'package:flutter/widgets.dart';
import 'package:putu_putu/src/routes/collect/collect.dart';
import 'package:putu_putu/src/routes/commodities/commodities.dart';
import 'package:putu_putu/src/routes/herders/herders.dart';
import 'package:putu_putu/src/routes/sync.dart';
import 'package:putu_putu/src/routes/settings_import.dart';
import 'package:rc_router/rc_router.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  RcRoutes rcRoutes;

  @override
  void initState() {
    super.initState();

    rcRoutes = RcRoutes(
      routes: [
        CommoditiesRoute(),
        CommodityDetailRoute(),
        LotDetailRoute(),
        CollectRoute(navigatorKey),
        HerdersRoute(navigatorKey),
        HerderDetailRoute(),
        SyncRoute(navigatorKey),
        CollectorRoute(),
        FlocksRoute(navigatorKey),
        FlockDetailRoute(),
        SettingsImportRoute(),
        ExportRoute(),
        // aboutRoute
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'putu-putu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //routes: {},
      home: Loading(), // just below
      debugShowCheckedModeBanner: false,
      onGenerateRoute: rcRoutes.onGeneratedRoute,
    );
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    final appStore = Provider.of<AppStore>(context, listen: false);
    //final flocksStore = Provider.of<FlocksStore>(context, listen: false);
    //final cartStore = Provider.of<CartStore>(context, listen: false);

    when(
      (_) => !appStore.initialLoading,
      () {
        Navigator.of(context).pushReplacementNamed(CollectRoute.routePath);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
