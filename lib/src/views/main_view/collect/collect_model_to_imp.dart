import 'dart:async';

import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/views/main_view/collect/app_bar_actions.dart';
//import 'package:come_share/src/stores/collector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:share/share.dart';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/routes/collect/herder.dart';
import 'package:come_share/src/routes/collect/note.dart';

//import 'package:come_share/src/routes/collect/commodities.dart'; // ? implement for wider use case
import 'package:come_share/src/routes/collect/flock.dart';
import 'package:come_share/src/stores/cart.dart';
import 'package:come_share/src/views/main_view/main_view.dart';

class SellView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigatorKey;

  SellView({@required this.mainNavigatorKey});

  @override
  _SellViewState createState() => _SellViewState();
}

class _SellViewState extends State<SellView>
    with SingleTickerProviderStateMixin {
  final navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription _actionSubscription;
  CartStore cartStore;
  RcRoutes rcRoutes;
  TabController tabController;
  bool onFlockPage = false;
  AppBarActions appBarActions;
  Flock _flock;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
    appBarActions = AppBarActions();
    //_actionSubscription = appBarActions.action.listen(onAppBarAction);
    rcRoutes = RcRoutes(
      routes: [
        // CalculatorRoute(
        //   onOk: onOkCalc,
        // ),
        NoteRoute(onOkOk: onOkNote),
        CollectHerderRoute(
          mainNavigatorKey: navigatorKey,
          onSubmit: onSubmitFlock,
          // ! Work In Progress
        ),
        // FlockRoute(),
      ],
    );
  }

  @override
  void dispose() {
    _actionSubscription?.cancel();
    super.dispose();
  }

  Future<void> onOkCalc() async {
    tabController.index = tabController.index + 1;
    //navigatorKey.currentState.pushReplacementNamed(
    //CalculatorRoute.routePath,
    //  );
  }

  Future<void> onOkNote() async {
    tabController.index = tabController.index + 1;
    navigatorKey.currentState.pushReplacementNamed(
      NoteRoute.routePath,
    );
  }

  Future<void> onSubmitFlock(Flock flock) async {
    _flock = flock;
    tabController.index = tabController.index + 1;
    setState(() {
      onFlockPage = true;
    });
    navigatorKey.currentState
        .pushReplacementNamed(CollectFlockRoute.routePath, arguments: flock);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appBarActions,
      child: Consumer<AppBarActions>(
        builder: (c, appBarActionsValue, _) {
          return MainView(
            mainNavigatorKey: widget.mainNavigatorKey,
            selectedIndex: 2,
            actions: appBarActionsValue.actions,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CollectTabBar(
                  tabController: tabController,
                  onTap: (index) {
                    if (onFlockPage && index != 0) {
                      tabController.index = 5;
                      return;
                    } else if (onFlockPage && index == 0) {
                      onFlockPage = false;
                    }
                    if (tabController.previousIndex == 5) {
                      if (index != 0) {
                        tabController.index = tabController.previousIndex;
                      }
                    } else if (index - 1 > tabController.previousIndex ||
                        index > 4) {
                      tabController.index = tabController.previousIndex;
                    }
                    if (tabController.index < rcRoutes.routes.length) {
                      navigatorKey.currentState.pushReplacementNamed(
                          rcRoutes.routes[tabController.index].path);
                    }
                  },
                ),
                Expanded(
                  child: Navigator(
                    key: navigatorKey,
                    onGenerateRoute: rcRoutes.onGeneratedRoute,
                    observers: [
                      CollectNavigatorObserver(appBarActions),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> onAppBarAction(AppBarAction event) async {}
}

class CollectNavigatorObserver extends NavigatorObserver {
  final AppBarActions appBarActions;

  CollectNavigatorObserver(this.appBarActions);
}

class CollectTabBar extends StatelessWidget {
  final TabController tabController;
  final ValueChanged<int> onTap;

  final List<String> tabsTitle = [
    'calc',
    'comment',
    'scan qr',
    'flock',
  ];

  CollectTabBar({@required this.tabController, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0xFF20272B),
            child: TabBar(
              onTap: onTap,
              controller: tabController,
              isScrollable: true,
              tabs: [
                for (final tabTitle in tabsTitle)
                  if (tabTitle == 'calc')
                    Tab(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Observer(
                              builder: (context) {
                                return Text(
                                  '${cartStore.qt} ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.tealAccent),
                                );
                              },
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Icon(Icons.confirmation_number),
                            ),
                            Text(
                              tabTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (tabTitle == 'comment')
                    Tab(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: Icon(Icons.comment),
                            ),
                            Text(
                              tabTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (tabTitle == 'scan qr')
                    Tab(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: Icon(Icons.contacts),
                            ),
                            Text(
                              tabTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (tabTitle == 'flock')
                    Tab(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: Icon(Icons.receipt),
                            ),
                            Text(
                              tabTitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Tab(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Text(
                          tabTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
