import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const Color defaultButtonBackgroundColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        children: _buttons(),
      ),
    );
  }

  List<Widget> _buttons() {
    var buttons = List<Widget>();
    buttons.add(_button(
      'C',
      () => _reset,
    ));
    return buttons;
  }

  Widget _button(
    String text,
    void Function() onTap, [
    Color backgroundColor = defaultButtonBackgroundColor,
  ]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }

  void _reset() => null;
}
