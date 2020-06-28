import 'package:come_share/src/stores/cart.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  static const Color defaultButtonBackgroundColor = Color(0xff42b2a6);
  static const Color importantButtonsColor = Color(0xfffa5c68);
  static const Color otherButtonsColor = Color(0xffffb733);
  static const Radius buttonCornerRadius = Radius.circular(12);
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
        padding: EdgeInsets.all(5),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
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
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: 80,
                  child: _validateButton(
                    context,
                    roundedCorner: RoundedCorner.bottom,
                  ),
                );
              },
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
              child: Text(currentCaptureValueText,
                  style: textStyle.copyWith(color: Colors.black)),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                fullCalculText,
                style: informationTextStyle.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buttons() {
    var buttons = List<Widget>();
    buttons.add(_numberButton(7, roundedCorner: RoundedCorner.topLeft));
    buttons.add(_numberButton(8));
    buttons.add(_numberButton(9, roundedCorner: RoundedCorner.topRight));
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
    buttons.add(_additionButton(roundedCorner: RoundedCorner.topRight));
    return buttons;
  }

  Widget _button(
    String text,
    void Function() onTap, {
    Color backgroundColor = defaultButtonBackgroundColor,
    double elevation = 2.5,
    Color splashColor = Colors.transparent,
    RoundedCorner roundedCorner,
  }) {
    ShapeBorder shape;

    switch (roundedCorner) {
      case RoundedCorner.topLeft:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: buttonCornerRadius),
        );
        break;
      case RoundedCorner.topRight:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: buttonCornerRadius),
        );
        break;
      case RoundedCorner.bottomLeft:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: buttonCornerRadius),
        );
        break;
      case RoundedCorner.bottomRight:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: buttonCornerRadius),
        );
        break;
      case RoundedCorner.bottom:
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: buttonCornerRadius, bottomRight: buttonCornerRadius),
        );
        break;
    }

    return Container(
      padding: EdgeInsets.all(4),
      child: MaterialButton(
        splashColor: splashColor,
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        elevation: elevation,
        onPressed: onTap,
        color: backgroundColor,
        shape: shape,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }

  Widget _resetAllButton() =>
      _button('AC', _resetAll, backgroundColor: importantButtonsColor);

  void _resetAll() {
    setState(() {
      pastvalues.clear();
      _reset();
    });
  }

  Widget _resetButton() =>
      _button('C', _reset, backgroundColor: importantButtonsColor);
  void _reset() => setState(() {
        currentCaptureValue = 0;
        isCapturing = true;
      });

  Widget _emptyButton() => _button('', null, elevation: 0);

  Widget _additionButton({RoundedCorner roundedCorner}) => _button(
        '+',
        _add,
        backgroundColor: otherButtonsColor,
        roundedCorner: roundedCorner,
      );
  void _add() => setState(() {
        pastvalues.add(currentCaptureValue);
        currentCaptureValue = 0;
        isCapturing = false;
      });

  Widget _numberButton(
    int number, {
    RoundedCorner roundedCorner,
  }) =>
      _button(
        number.toString(),
        () => _numberClicked(number),
        roundedCorner: roundedCorner,
      );
  void _numberClicked(int number) => setState(() {
        isCapturing = true;
        currentCaptureValue = currentCaptureValue * 10 + number;
      });

  Widget _validateButton(
    BuildContext context, {
    RoundedCorner roundedCorner,
  }) {
    return _button(
      'Valider',
      () => _validateAndLoadNextView(context),
      roundedCorner: roundedCorner,
    );
  }

  void _validateAndLoadNextView(
    BuildContext context,
  ) {
    final cartStore = Provider.of<CartStore>(context);
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    final collectorViewManager = Provider.of<CollectorViewsManager>(context);
    cartStore.addLot(
        commoditiesStore.commodities.first.lots.first, total.toDouble());
    collectorViewManager.activeView = CollectorViews.scanner;
  }
}

enum RoundedCorner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  bottom,
}
