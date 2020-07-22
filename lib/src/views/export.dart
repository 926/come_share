import 'dart:async' show Future;
import 'package:come_share/src/widgets/drawer.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'dart:io';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:intent/intent.dart' as intent;
import 'package:intent/extra.dart' as intent_extra;
import 'package:intent/action.dart' as intent_action;
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/utils/save_excel.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/stores/flocks.dart';
//import 'package:come_share/src/utils/basic_dialog.dart';
//import 'package:come_share/src/stores/collector.dart';

class Export extends StatefulWidget {
  Export({
    Key key,
  }) : super(key: key);

  @override
  ExportState createState() => ExportState();
}

class ExportState extends State<Export> {
  String state;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    getAppDirectory();
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getExternalStorageDirectory();
    });
  }

  Future<void> shareFile(String string) async {
    String dir = (await getExternalStorageDirectory()).absolute.path;
    await FlutterShare.shareFile(
      title: 'Csv comeshare',
      text: 'Bonne réception',
      filePath: '$dir/$string',
    );
  }

//TOBE tested on android, check ios
  Future<void> shareExcelFile(String string) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "collecte.");
    ByteData data = await rootBundle.load("assets/collecte.xlsx");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    await FlutterShare.shareFile(
      title: 'excel comeshare',
      text: 'Bonne réception',
      filePath: '$File/collecte.xlsx',
    );
  }

  // these files are meant to be visible to the user, use below if hidden needed
  // getApplicationDocumentsDirectory();

  @override
  Widget build(BuildContext context) {
    // final collectorStore = Provider.of<CollectorStore>(context);
    // final thiscollector = collectorStore.collector.first;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Export .csv / .xlsl'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              //color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.receipt,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.share),
                  ),
                  Expanded(
                      child: Text(
                          'Sauvegarder et partager \nle fichier collecte sous .csv')),
                ],
              ),
              onPressed: () {
                getFlocksCsv(context);
                shareFile('flocks.csv');
              },
            ),
            RaisedButton(
              //color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.receipt,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.share),
                  ),
                  Expanded(
                      child: Text(
                          'Sauvegarder et partager \nle fichier collecte sous excel')),
                ],
              ),
              onPressed: () {
                getFlocksExcel(context);
                shareExcelFile('flocks.xlsl');
              },
            ),
            /* RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.save),
                  Icon(Icons.share),
                  Text(
                    'Sauvegarder et \npartager la base de données',
                  ),
                ],
              ),
              onPressed: () async {
                final database = Provider.of<Database>(context, listen: false);
                var content = await exportDatabase(database); //? does this work
                var saved = jsonEncode(content);
                String dir =
                    (await getExternalStorageDirectory()).absolute.path + "/";
                var file = "$dir";
                print(" FILE " +
                    file); // LOGTAG+ was originally in the " " but I removed it
                File f = new File(file + "comeshare_db.json");
                await f.writeAsString(saved);
                shareFile('comeshare_db.json');
              },
            ),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.storage),
                  Icon(Icons.file_upload),
                  Text(
                    'Charger une base de données',
                  ),
                ],
              ),
              onPressed: () async {
                //if (thisCollector.isLocked == true) {
                //  return showDialogCS('Permission requise', context);
                //} else {
                final isOkToErase = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (c) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.report_problem),
                          Icon(Icons.delete_forever),
                          Text(
                              'Attention l\'import de la db est irréversible. Êtes vous sur de vouloir continuer ?\n (une copie de la db actuelle est sauvegardée automatiquement)'),
                          Row(
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
                        ],
                      ),
                    );
                  },
                );
                if (!isOkToErase) {
                  return;
                }
                final database = Provider.of<Database>(context, listen: false);
                var content =
                    await exportDatabase(database); // this does not work
                var saved = jsonEncode(content);
                String dir =
                    (await getExternalStorageDirectory()).absolute.path + "/";
                var file = "$dir";
                File f = new File(file + "comeshare.json");
                await f.writeAsString(saved);
                final loadFile = await FilePicker.getFile(
                    type: FileType.any, allowedExtensions: ['json']);
                if (loadFile == null) {
                  return;
                } else {
                  DatabaseFactory dbFactory = databaseFactoryIo;
                  final loadedFiled = await loadFile.readAsString();
                  var map = jsonDecode(loadedFiled) as Map;
                  var importedDb =
                      await importDatabase(map, dbFactory, '${loadFile.path}');
                  return showDialogCSOk(
                      'Ancienne db effacée. \nChargement de la nouvelle db version ${importedDb.version} terminé',
                      context);
                }
              },
            ), */
            RaisedButton(
                child: Text("Ouvrir google sheets"),
                onPressed: () async {
                  intent.Intent()
                    ..setAction(intent_action.Action.ACTION_SHOW_APP_INFO)
                    ..putExtra(intent_extra.Extra.EXTRA_PACKAGE_NAME,
                        "com.google.android.apps.docs.editors.sheets")
                    ..startActivity().catchError((e) => print(e));
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Directory>(
                future: _appDocDir,
                builder:
                    (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                  Text text = Text('');
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      text = Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      text = Text(
                          'Le fichier est dans le Path: \n${snapshot.data.path}');
                    } else {
                      text = Text('Unavailable');
                    }
                  }
                  return new Container(
                    child: text,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

getFlocksCsv(BuildContext context) async {
// create an element rows of type list of list. All the above data set are stored in associate list
// Let associate be a model class with attributes name, gender and age and associateList be a list of associate model class.
  final flocksStore = Provider.of<FlocksStore>(context, listen: false);
  final herdersStore = Provider.of<HerdersStore>(context, listen: false);
  final commoditiesStore =
      Provider.of<CommoditiesStore>(context, listen: false);
  List<List<dynamic>> rows = List<List<dynamic>>();
  List<dynamic> flocksHeader = List();
  flocksHeader.add('id');
  //flocksHeader.add('recu_verse');
  flocksHeader.add('date');
  //flocksHeader.add('flockType');
  flocksHeader.add('bidon');
  flocksHeader.add('qt');
  flocksHeader.add('denree');
  flocksHeader.add('status');
  flocksHeader.add('status maj');
  rows.add(flocksHeader);
  for (int i = 0; i < flocksStore.flocks.length; i++) {
// row refer to each column of a row in csv file and rows refer to each row in a file
    for (int j = 0; j < flocksStore.flocks[i].items.length; j++) {
      var bidon = 0;
      if (herdersStore.herders
          .any((h) => '${h.id}' == flocksStore.flocks[i].herderId)) {
        bidon = herdersStore.herders
            .firstWhere((h) => '${h.id}' == flocksStore.flocks[i].herderId)
            .bidon;
      }

      var commodityName = 'inconnue';
      if (commoditiesStore.commodities
          .any((c) => c.id == flocksStore.flocks[i].items[j].lot.commodityId)) {
        commodityName = commoditiesStore.commodities
            .firstWhere(
                (c) => c.id == flocksStore.flocks[i].items[j].lot.commodityId)
            .name;
      }
      List<dynamic> cells = List();
      cells.add(flocksStore.flocks[i].key);
      //cells.add(flocksStore.flocks[i].received);
      cells.add(flocksStore.flocks[i].date.toString().substring(0, 19));
      //cells.add(flocksStore.flocks[i].flockType.toString());
      cells.add(bidon);
      cells.add(flocksStore?.flocks[i]?.items[j]?.quantity ?? 0);
      cells.add(commodityName);
      cells.add(flocksStore.flocks[i].status);
      cells.add(
          flocksStore.flocks[i].statusUpdateDate.toString().substring(0, 19));
      rows.add(cells);
    }
  }
  String dir = (await getExternalStorageDirectory()).absolute.path + "/";
  var file = "$dir";
  print(" FILE " + file); // LOGTAG+ was originally in the " " but I removed it
  File f = new File(file + "collectes.csv");

// convert rows to String and write as csv file

  String csv = const ListToCsvConverter().convert(rows);
  f.writeAsString(csv);
}

Future<void> getFlocksExcel(BuildContext context) async {
  var file = "assets/collecte.xlsx";
  ByteData data = await rootBundle.load(file);
  bool exists = data != null;
  if (exists) {
    final DateTime now = DateTime.now();
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    var sheet = decoder.tables.keys.first;

    /*     DateTime selectedMonth = DateTime(
        date.year,
        date.month,
        DateTime(date.year, date.month + 1, 0)
            .day); // hack to get the last day of the month
 */

    decoder
      ..updateCell(sheet, 0, 0, 'id')
      ..updateCell(sheet, 1, 0, 'date')
      ..updateCell(sheet, 2, 0, 'bidon')
      ..updateCell(sheet, 3, 0, 'qt')
      ..updateCell(sheet, 4, 0, 'denree');

    final flocksStore = Provider.of<FlocksStore>(context);
    final herdersStore = Provider.of<HerdersStore>(context);
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    final thoseFlocks = flocksStore.flocks.toList();

    for (int i = 0; i < thoseFlocks.length; i++) {
      final Flock thisFlock = thoseFlocks[i];
      int newRow = decoder.tables.values.first.maxRows;

      var bidon = 0;
      if (herdersStore.herders
          .any((h) => '${h.id}' == flocksStore.flocks[i].herderId)) {
        bidon = herdersStore.herders
            .firstWhere((h) => '${h.id}' == flocksStore.flocks[i].herderId)
            .bidon;
      }

      for (int j = 0; j < thisFlock.items.length; j++) {
        var commodityName = 'inconnue';
        var qt = flocksStore?.flocks[i]?.items[j]?.quantity ?? 0;
        if (commoditiesStore.commodities.any(
            (c) => c.id == flocksStore.flocks[i].items[j].lot.commodityId)) {
          commodityName = commoditiesStore.commodities
              .firstWhere(
                  (c) => c.id == flocksStore.flocks[i].items[j].lot.commodityId)
              .name;
        }
        decoder
          ..insertRow(sheet, newRow)
          ..updateCell(sheet, 0, newRow, '${thisFlock.key}')
          ..updateCell(sheet, 1, newRow,
              '${thisFlock?.date.toString().substring(0, 19)}')
          ..updateCell(sheet, 2, newRow, "$bidon")
          ..updateCell(sheet, 3, newRow, "$qt")
          ..updateCell(sheet, 4, newRow, "$commodityName");
      }
    }
    // print('${decoder.tables.values.first.rows.length}');
    // print('${decoder.tables.values.first.rows.last.toString()}');
    saveExcelFile(decoder, context, now, 'collecte');
  }
}
