import 'package:flutter/material.dart';

Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Êtes vous sur ?'),
        content: Text('Vous allez quitter l\'application'),
        actions: <Widget>[
          FlatButton(
            child: Text('Rester'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          Spacer(),
          FlatButton(
            child: Text('Quitter'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
