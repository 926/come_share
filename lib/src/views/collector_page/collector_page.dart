import 'package:come_share/src/views/collector_page/scanner_view.dart';
import 'package:flutter/material.dart';

import 'calculator_view.dart';

class CollectorPage extends StatefulWidget {
  @override
  _CollectorPageState createState() => _CollectorPageState();
}

class _CollectorPageState extends State<CollectorPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          FlatButton(
              color: Colors.white,
              onPressed: () =>
                  _tabController.animateTo(_tabController.index + 1),
              child: Text('Load Next Page')),
        ],
      ),
    );
  }
}
