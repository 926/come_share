import 'dart:io' as io;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:come_share/src/utils/basic_dialog.dart';

Future saveExcelFile(SpreadsheetDecoder decoder, BuildContext buildContext,
    DateTime now, String title) async {
  if (io.Platform.isIOS) {
    showDialogCSNotOk('excel export might bug in iOS ', buildContext);
    String dir = (await getExternalStorageDirectory()).absolute.path + "/";
    var myFile = io.File(
        '$dir${title}_${now.year}_${now.month}_${now.day}T${now.hour}-${now.minute}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(decoder.encode());
    //openDownloadDirectory(buildContext);
    showDialogCS('${myFile.uri}', buildContext);
    print('${myFile.uri}');
  } else if (io.Platform.isAndroid) {
    String dir = (await getExternalStorageDirectory()).absolute.path + "/";
    var myFile = io.File(
        '$dir${title}_${now.year}_${now.month}_${now.day}T${now.hour}-${now.minute}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(decoder.encode());
    //openDownloadDirectory(buildContext);
    showDialogCS('${myFile.uri}', buildContext);
    print('${myFile.uri}');
  } else if (io.Platform.isMacOS) {
    showDialogCSNotOk('no mac support yet ', buildContext);
  } else if (io.Platform.isWindows) {
    showDialogCSNotOk('no windows support yet ', buildContext);
  } else if (io.Platform.isLinux) {
    showDialogCSNotOk('Sorry we do not do linux', buildContext);
  } else {
    showDialogCSNotOk('Sorry we do not do gameboys', buildContext);
  }
}
