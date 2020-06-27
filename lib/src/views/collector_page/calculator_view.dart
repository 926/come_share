import 'package:come_share/src/views/widgets/calculator.dart';
import 'package:flutter/cupertino.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Calculator(),
        ],
      ),
    );
  }
}
