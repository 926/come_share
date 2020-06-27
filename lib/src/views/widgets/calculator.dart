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
        crossAxisCount: 3,
        children: _buttons(),
      ),
    );
  }

  List<Widget> _buttons() {
    var buttons = List<Widget>();
    // buttons.add(_emptyButton());
    // buttons.add(_emptyButton());
    // buttons.add(_resetButton());
    // buttons.add(_divisionButton());
    buttons.add(_numberButton(7));
    buttons.add(_numberButton(8));
    buttons.add(_numberButton(9));
    // buttons.add(_multiplicationButton());
    buttons.add(_numberButton(4));
    buttons.add(_numberButton(5));
    buttons.add(_numberButton(6));
    // buttons.add(_substractionButton());
    buttons.add(_numberButton(1));
    buttons.add(_numberButton(2));
    buttons.add(_numberButton(3));
    buttons.add(_numberButton(0));
    buttons.add(_additionButton());
    buttons.add(_resetButton());
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
        child: Center(child: Text(text)),
      ),
    );
  }

  // all buttons

  // Reset button
  Widget _resetButton() => _button(
        'C',
        () => _reset,
      );
  void _reset() => null;

  // Empty button
  Widget _emptyButton() => _button('', () => null);

  // Division button
  Widget _divisionButton() => _button('/', () => _divide);
  void _divide() => null;

  // Multiplication button
  Widget _multiplicationButton() => _button('X', () => _multiply);
  void _multiply() => null;

  // Add button
  Widget _additionButton() => _button('+', () => _add);
  void _add() => null;

  // Substraction button
  Widget _substractionButton() => _button('-', () => _substract);
  void _substract() => null;

  // Number button
  Widget _numberButton(int number) =>
      _button(number.toString(), () => _numberClicked(number));
  void _numberClicked(int number) => null;
}
