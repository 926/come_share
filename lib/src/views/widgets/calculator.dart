import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const Color defaultButtonBackgroundColor = Colors.grey;
  final TextStyle textStyle = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
  );
  final TextStyle informationTextStyle = TextStyle(
    color: Colors.white.withOpacity(0.6),
    decoration: TextDecoration.none,
    fontSize: 14,
  );

  bool isCapturing = false;

  int currentCaptureValue = 0;
  String get currentCaptureValueText =>
      isCapturing ? currentCaptureValue.toString() : total.toString();

  List<int> pastvalues = List<int>();
  int get total {
    var tot = 0;
    pastvalues.forEach((value) => tot += value);
    return tot;
  }

  String get fullCalculText {
    if (pastvalues.length == 0) return '0';
    var text = '';
    for (var i = 0; i < pastvalues.length - 1; i++) {
      text += pastvalues[i].toString() + '+';
    }
    text += pastvalues.last.toString();

    text += ' = ' + total.toString();
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        child: Column(
          children: <Widget>[
            _calculView(),
            SizedBox(
              height: constraints.maxWidth,
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                children: _buttons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calculView() {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        padding: EdgeInsets.only(right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(currentCaptureValueText, style: textStyle),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(fullCalculText, style: informationTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buttons() {
    var buttons = List<Widget>();
    buttons.add(_numberButton(7));
    buttons.add(_numberButton(8));
    buttons.add(_numberButton(9));
    buttons.add(_emptyButton());
    buttons.add(_numberButton(4));
    buttons.add(_numberButton(5));
    buttons.add(_numberButton(6));
    buttons.add(_emptyButton());
    buttons.add(_numberButton(1));
    buttons.add(_numberButton(2));
    buttons.add(_numberButton(3));
    buttons.add(_emptyButton());
    buttons.add(_numberButton(0));
    buttons.add(_resetAllButton());
    buttons.add(_resetButton());
    buttons.add(_additionButton());
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
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }

  // all buttons

  // Reset all button
  Widget _resetAllButton() => _button('AC', _resetAll, Colors.red);
  void _resetAll() {
    setState(() {
      pastvalues.clear();
      _reset();
    });
  }

  // Reset button
  Widget _resetButton() => _button('C', _reset, Colors.red);
  void _reset() => setState(() {
        currentCaptureValue = 0;
        isCapturing = true;
      });

  // Empty button
  Widget _emptyButton() => _button('', () => null);

  // Add button
  Widget _additionButton() => _button('+', _add, Colors.orange);
  void _add() => setState(() {
        pastvalues.add(currentCaptureValue);
        currentCaptureValue = 0;
        isCapturing = false;
      });

  // Number button
  Widget _numberButton(int number) =>
      _button(number.toString(), () => _numberClicked(number));
  void _numberClicked(int number) => setState(() {
        isCapturing = true;
        currentCaptureValue = currentCaptureValue * 10 + number;
      });
}
