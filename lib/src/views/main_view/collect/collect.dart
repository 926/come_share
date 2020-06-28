import 'package:come_share/src/views/main_view/collect/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_view.dart';

class Collect extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigator;

  Collect({@required this.mainNavigator});

  @override
  _CollectState createState() => _CollectState();
}

enum CollectorViews {
  calculator,
  scanner,
  validation,
}

class CollectorViewsManager with ChangeNotifier {
  CollectorViews _activeView = CollectorViews.scanner;
  CollectorViews get activeView => _activeView;
  set activeView(CollectorViews nextView) {
    _activeView = nextView;
    notifyListeners();
  }
}

class _CollectState extends State<Collect> with SingleTickerProviderStateMixin {
  TabController _tabController;

  CollectorViewsManager _collectorViewsManager = CollectorViewsManager();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _collectorViewsManager.addListener(
      () => updateActiveView(_collectorViewsManager.activeView),
    );
    super.initState();
  }

  @override
  void dispose() {
    _collectorViewsManager.removeListener(
      () => updateActiveView(_collectorViewsManager.activeView),
    );
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectorViewsManager>.value(
      value: _collectorViewsManager,
      child: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  CalculatorView(),
                  ScannerView(),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int collectorViewsToTabIndex(CollectorViews view) {
    switch (view) {
      case CollectorViews.calculator:
        return 1;
      case CollectorViews.scanner:
        return 1;
      case CollectorViews.validation:
        return 2;
      default:
        throw Exception('Unkown view');
    }
  }

  void updateActiveView(CollectorViews nextView) {
    _tabController.animateTo(collectorViewsToTabIndex(nextView));
  }
}
