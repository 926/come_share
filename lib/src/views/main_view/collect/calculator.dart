import 'package:come_share/src/stores/cart.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

// ! si tu fais évoluer la calculatrice pour par exemple  :
// ! choisir x ou y produit
// ! **verrouille les lots,
// pas plus d'un lot par produit
// voir même un produit == un lot

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  static const Color defaultButtonBackgroundColor = Colors.blueGrey;
  static const Color importantButtonsColor = Color(0xfffa5c68);
  static const Color otherButtonsColor = Colors.blue;
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

  String get currentCaptureValueText {
    return currentCaptureValue == 0 ? '' : currentCaptureValue.toString();
  }

  List<int> pastvalues = List<int>();

  int get total {
    var tot = 0;
    pastvalues.forEach((value) => tot += value);
    tot += currentCaptureValue;
    return tot;
  }

  String get fullCalculText {
    if (pastvalues.length == 0) return '0';
    var text = '';
    for (var i = 0; i < pastvalues.length - 1; i++) {
      if (pastvalues[i] != 0) {
        text += pastvalues[i].toString() + '+';
      }
    }
    text += pastvalues.last.toString();

    if (currentCaptureValue != 0) {
      text += '+' + currentCaptureValue.toString();
    }

    text += ' = ';
    return text;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight =
        (size.height - kToolbarHeight - size.height * 0.25) / 2;
    final double itemWidth = (size.width + size.width * 0.1) / 2;

    final cartStore = Provider.of<CartStore>(context, listen: false);
    cartStore.clearItems();
    cartStore.clearHerder();
    //cartStore.clearComment();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('OK'),
        onPressed: () => _validateAndLoadNextView(context),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.80,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _calculView(),
                        GridView.count(
                          childAspectRatio: (itemWidth / itemHeight),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          crossAxisCount: 3,
                          children: _buttons(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height * 0.11),
                        Expanded(
                            child: _additionButton(
                                roundedCorner: RoundedCorner.topRight)),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _calculView() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.width * 0.1,
      padding: EdgeInsets.only(right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /* FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                currentCaptureValueText,
                style: textStyle.copyWith(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ), */
          FittedBox(
            fit: BoxFit.fitWidth,
            child: RichText(
              text: TextSpan(
                style: informationTextStyle.copyWith(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(text: fullCalculText == '0' ? ' ' : fullCalculText),
                  //if (pastvalues.length > 0)
                  TextSpan(
                    text: total == 0 ? '' : total.toString(),
                    style: informationTextStyle.copyWith(
                        color: Colors.black, fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buttons() {
    var buttons = List<Widget>();
    buttons.add(_numberButton(7, roundedCorner: RoundedCorner.topLeft));
    buttons.add(_numberButton(8));
    buttons.add(_numberButton(9, roundedCorner: RoundedCorner.topRight));
    buttons.add(_numberButton(4));
    buttons.add(_numberButton(5));
    buttons.add(_numberButton(6));
    buttons.add(_numberButton(1));
    buttons.add(_numberButton(2));
    buttons.add(_numberButton(3));
    buttons.add(_numberButton(0));
    buttons.add(_resetAllButton());
    buttons.add(_resetButton());

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

  Widget _additionButton({RoundedCorner roundedCorner}) => _button(
        '+',
        _add,
        backgroundColor: Colors.grey,
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

  void _validateAndLoadNextView(
    BuildContext context,
  ) {
    final cartStore = Provider.of<CartStore>(context);
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    final _commodities = commoditiesStore.commodities.toList(growable: false);
    final collectorViewManager = Provider.of<CollectorViewsManager>(context);
    //print(_commodities.length);
    cartStore.addLot(_commodities[1].lots.first, total.toDouble());
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
