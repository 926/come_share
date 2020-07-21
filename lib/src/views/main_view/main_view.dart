import 'dart:ui';
import 'package:come_share/src/routes/flocks/flocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';

import 'package:come_share/src/routes/herders/herders.dart';
import 'package:come_share/src/routes/sync.dart';
import 'package:come_share/src/utils/back_pressed.dart';
import 'package:come_share/src/routes/collect/collect.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/widgets/drawer.dart';

class MainView extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final GlobalKey<NavigatorState> mainNavigatorKey;
  final Widget floatingButton;
  final List<Widget> actions;

  MainView({
    @required this.body,
    @required this.selectedIndex,
    @required this.mainNavigatorKey,
    this.floatingButton,
    this.actions = const [],
  });

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<String> paths = [
    HerdersRoute.routePath,
    CollectRoute.routePath,
    FlocksRoute.routePath,
    SyncRoute.routePath,
  ];

  List<Color> selectedColor = [
    Colors.blue[800],
    Colors.teal,
    Colors.blueGrey,
    Color(0xff82AAED),
  ];

  @override
  Widget build(BuildContext context) {
    //final cartStore = Provider.of<CartStore>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor[widget.selectedIndex],
        title: InkWell(
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String appName = packageInfo.appName;
            String version = packageInfo.version;
            String buildNumber = packageInfo.buildNumber;
            showDialogCS(
                '$appName \nversion : $version buildNumber : $buildNumber',
                context);
          },
          child: Text(
            'Come Share',
            style: TextStyle(),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: widget.actions,
      ),
      drawer: AppDrawer(),
      body: WillPopScope(
          onWillPop: () => onBackPressed(context), child: widget.body),
      floatingActionButton: widget.floatingButton,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: selectedColor[widget.selectedIndex],
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF20272B),
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.selectedIndex,
        onTap: (newIndex) {
          if (paths[newIndex] != null) {
            widget.mainNavigatorKey.currentState
                .pushReplacementNamed(paths[newIndex]);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text('Eleveurs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            title: Text('Collecte'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Reçus'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            title: Text('Sync'),
          ),
        ],
      ),
    );
  }
}
