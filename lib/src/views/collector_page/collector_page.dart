import 'package:come_share/src/views/collector_page/scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_view.dart';

class CollectorPage extends StatefulWidget {
  @override
  _CollectorPageState createState() => _CollectorPageState();
}

enum CollectorViews {
  scanner,
  calculator,
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

class _CollectorPageState extends State<CollectorPage>
    with SingleTickerProviderStateMixin {
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

  int collectorViewsToTabIndex(CollectorViews view) {
    switch (view) {
      case CollectorViews.scanner:
        return 1;
      case CollectorViews.calculator:
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
