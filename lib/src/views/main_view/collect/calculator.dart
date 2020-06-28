import 'package:come_share/src/stores/cart.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

class CalculatorView extends StatefulWidget {
  static const Color defaultButtonBackgroundColor = Colors.grey;

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextStyle textStyle = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
    fontSize: 22,
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
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.transparent,
              child: LayoutBuilder(
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
              ),
            ),
            Consumer<CollectorViewsManager>(
              builder: (context, collectorViewManager, child) => FlatButton(
                child: Text('OK', style: textStyle),
                onPressed: () {
                  final cartStore = Provider.of<CartStore>(context);
                  final commoditiesStore =
                      Provider.of<CommoditiesStore>(context);
                  cartStore.addLot(
                      commoditiesStore.commodities.first.lots.first,
                      total.toDouble());
                  collectorViewManager.activeView = CollectorViews.validation;
                },
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
    void Function() onTap, {
    Color backgroundColor = CalculatorView.defaultButtonBackgroundColor,
    double elevation = 2.5,
    Color splashColor = Colors.black,
  }) {
    return Container(
      padding: EdgeInsets.all(4),
      child: MaterialButton(
        splashColor: splashColor,
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        elevation: elevation,
        onPressed: onTap,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  Widget _resetAllButton() =>
      _button('AC', _resetAll, backgroundColor: Colors.red);

  void _resetAll() {
    setState(() {
      pastvalues.clear();
      _reset();
    });
  }

  Widget _resetButton() => _button('C', _reset, backgroundColor: Colors.red);

  void _reset() => setState(() {
        currentCaptureValue = 0;
        isCapturing = true;
      });

  Widget _emptyButton() => _button('', null, elevation: 0);

  Widget _additionButton() =>
      _button('+', _add, backgroundColor: Colors.orange);

  void _add() => setState(() {
        pastvalues.add(currentCaptureValue);
        currentCaptureValue = 0;
        isCapturing = false;
      });

  Widget _numberButton(int number) =>
      _button(number.toString(), () => _numberClicked(number));

  void _numberClicked(int number) => setState(() {
        isCapturing = true;
        currentCaptureValue = currentCaptureValue * 10 + number;
      });
}
