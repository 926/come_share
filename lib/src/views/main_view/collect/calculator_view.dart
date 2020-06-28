import 'package:come_share/src/widgets/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

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
