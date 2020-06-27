import 'package:come_share/src/loading.dart';
import 'package:come_share/src/views/collector_page/collector_page.dart';
import 'package:flutter/material.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/home_page.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  RcRoutes rcRoutes;

  @override
  void initState() {
    super.initState();
    rcRoutes = RcRoutes(routes: [
      //MyHomePageRoute(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        MyHomePage.routePath: (context) =>
            MyHomePage(title: 'Come Share Demo Home Page'),
      },
      home: CollectorPage(),
      // home: Loading(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: rcRoutes.onGeneratedRoute,
    );
  }
}
