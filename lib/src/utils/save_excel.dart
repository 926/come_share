import 'dart:io' as io;
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:putu_putu/src/utils/basic_dialog.dart';

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
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "collecte.xlsx");
    ByteData data = await rootBundle.load("assets/collecte.xlsx");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
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
