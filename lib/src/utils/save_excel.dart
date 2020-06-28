import 'dart:io' as io;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:come_share/src/utils/basic_dialog.dart';

Future saveExcelFile(SpreadsheetDecoder decoder, BuildContext buildContext,
    DateTime now, String title) async {
  if (io.Platform.isIOS) {
    showDialogCSNotOk('Sorry excel export might bug in iOS ', buildContext);
  } else if (io.Platform.isAndroid) {
    //showDialogCSNotOk('Sorry we do not do android yet', buildContext);
  } else if (io.Platform.isMacOS) {
    final current = io.Directory.current;
    var myFile = io.File(
        '${current.path}/${title}_${now.year}_${now.month}_${now.day}T${now.hour}-${now.minute}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(decoder.encode());
    //await openDownloadDirectory(buildContext);
    print('${myFile.uri}');
  } else if (io.Platform.isWindows) {
    io.Directory appDocDir = await getApplicationDocumentsDirectory();
    var myFile = io.File(
        '${appDocDir.path}/${title}_${now.year}_${now.month}_${now.day}T${now.hour}-${now.minute}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(decoder.encode());
    //openDownloadDirectory(buildContext);
    showDialogCS('${myFile.uri}', buildContext);
    print('${myFile.uri}');
  } else if (io.Platform.isLinux) {
    showDialogCSNotOk('Sorry we do not do linux', buildContext);
  } else {
    showDialogCSNotOk('Sorry we do not do gameboys', buildContext);
  }
}
