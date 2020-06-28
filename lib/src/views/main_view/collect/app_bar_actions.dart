import 'dart:async';

import 'package:flutter/material.dart';

enum AppBarAction {
  shareFlock,
  printFlock,
  scan,
  search,
}

class AppBarActions extends ChangeNotifier {
  static List<Widget> emptyActions = [];


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
