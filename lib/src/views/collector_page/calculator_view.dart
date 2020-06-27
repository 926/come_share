import 'package:come_share/src/views/widgets/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'collector_page.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Calculator(),
          Consumer<CollectorViewsManager>(
            builder: (context, collectorViewManager, child) => FlatButton(
              onPressed: () =>
                  collectorViewManager.activeView = CollectorViews.validation,
              child: Text('Validate'),
            ),
          ),
        ],
      ),
    );
  }
}
