import 'package:flutter/material.dart';

void showDialogWeebi(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showDialogWeebiOk(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        content:FlatButton(
            child:  Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        actions: <Widget>[
          FlatButton(
            child: Text("ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showDialogWeebiNotOk(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        content:FlatButton(
            child:  Icon(Icons.sentiment_very_dissatisfied, color: Colors.red,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        actions: <Widget>[
          FlatButton(
            child: Text("ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
