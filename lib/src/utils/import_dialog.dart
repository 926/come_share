import 'package:flutter/material.dart';

// not working
Future<bool> showDialogImport(BuildContext context) {
  final isOkToErase = showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (c) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'L\'import de la liste se fait à partir d\'un fichier .json. '),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  FlatButton(
                    child: Text('Non'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  RaisedButton(
                    child: Text('Oui'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
  return isOkToErase;
}
