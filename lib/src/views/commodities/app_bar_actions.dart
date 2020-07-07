//import 'dart:async';

import 'package:flutter/material.dart';

//to DO implement this

enum AppBarAction {
  scan,
  search,
}

class AppBarActions extends ChangeNotifier {
  static List<Widget> emptyActions = [];

  static List<Widget> commoditiesActions = [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        // launch the barcodeText()
      },
    )
  ];

  static List<Widget> stockActions = [
    IconButton(
      icon: Icon(Icons.share),
      onPressed: () {
        //_actionController.add(AppBarAction.shareTicket);
      },
    ),
    IconButton(
      icon: Icon(Icons.print),
      onPressed: () {
        //_actionController.add(AppBarAction.printTicket);
      },
    )
  ];

  //static final _actionController = StreamController<AppBarAction>.broadcast();

  List<Widget> _actions;

  AppBarActions() : _actions = emptyActions;

  List<Widget> get actions => _actions;

  //Stream<AppBarAction> get action => _actionController.stream;

  set actions(List<Widget> actions) {
    _actions = actions;
    notifyListeners();
  }
}
