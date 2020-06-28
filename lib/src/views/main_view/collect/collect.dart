import 'package:come_share/src/views/main_view/collect/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_view.dart';

class Collect extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigatorKey;
  Collect({@required this.mainNavigatorKey});
  @override
  _CollectState createState() => _CollectState();
}

enum CollectViews {
  scanner,
  calculator,
  validation,
}

class CollectViewsManager with ChangeNotifier {
  CollectViews _activeView = CollectViews.scanner;
  CollectViews get activeView => _activeView;
  set activeView(CollectViews nextView) {
    _activeView = nextView;
    notifyListeners();
  }
}

class _CollectState extends State<Collect> with SingleTickerProviderStateMixin {
  TabController _tabController;

  CollectViewsManager _collectViewsManager = CollectViewsManager();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _collectViewsManager.addListener(
      () => updateActiveView(_collectViewsManager.activeView),
    );
    super.initState();
  }

  @override
  void dispose() {
    _collectViewsManager.removeListener(
      () => updateActiveView(_collectViewsManager.activeView),
    );
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectViewsManager>.value(
      value: _collectViewsManager,
      child: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  ScannerView(),
                  CalculatorView(),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int collectViewsToTabIndex(CollectViews view) {
    switch (view) {
      case CollectViews.scanner:
        return 1;
      case CollectViews.calculator:
        return 1;
      case CollectViews.validation:
        return 2;
      default:
        throw Exception('Unkown view');
    }
  }

  void updateActiveView(CollectViews nextView) {
    _tabController.animateTo(collectViewsToTabIndex(nextView));
  }
}
