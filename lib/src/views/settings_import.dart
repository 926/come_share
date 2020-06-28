import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/stores/commodities.dart';
//import 'package:come_share/src/stores/collector.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/utils/import_dialog.dart';
// import 'package:collection/collection.dart'; // does not sem so useful

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SettingsImportView extends StatefulWidget {
  SettingsImportView({Key key}) : super(key: key);

  @override
  SettingsImportViewState createState() => SettingsImportViewState();
}

class SettingsImportViewState extends State<SettingsImportView> {
  List<Commodity> preserveOldCommoditiesAndRemoveDuplicates(
      List<Commodity> _oldList, List<Commodity> _newList) {
    Map<String, Commodity> mapOldList = {};
    for (var p in _oldList) {
      mapOldList[p.name] = p;
    }
    Map<String, Commodity> mapNewList = {};
    for (var p in _newList) {
      mapNewList[p.name] = p;
    }
    for (var commodity in _newList) {
      if (mapOldList.keys.contains(commodity.name)) {
        mapNewList.remove(commodity.name);
      }
    }
    return _oldList.followedBy(mapNewList.values.toList()).toList();
    // on peut même + tard identifier les éléments nouveaux et les doublons
    // mapNewList.values.toList().length
  }

  List<Herder> preserveOldHerdersAndRemoveDuplicates(
      List<Herder> _oldList, List<Herder> _newList) {
    Map<String, Herder> mapOldListFirstNames = {};
    for (var herder in _oldList) {
      mapOldListFirstNames[herder.firstName] = herder;
    }
    Map<String, Herder> mapNewListFirstNames = {};
    for (var herder in _newList) {
      mapNewListFirstNames[herder.firstName] = herder;
    }
    Map<String, Herder> mapOldListLastNames = {};
    for (var herder in _oldList) {
      mapOldListLastNames[herder.lastName] = herder;
    }
    Map<String, Herder> mapNewListLastNames = {};
    for (var herder in _newList) {
      mapNewListLastNames[herder.lastName] = herder;
    }
    Map<String, Herder> mapOldListBidon = {};
    for (var herder in _oldList) {
      mapOldListBidon[herder.bidon.toString()] = herder;
    }
    Map<String, Herder> mapNewListBidon = {};
    for (var herder in _newList) {
      mapNewListBidon[herder.bidon.toString()] = herder;
    }
    for (var herder in _newList) {
      if (mapOldListFirstNames.keys.contains(herder.firstName)) {
        mapNewListFirstNames.remove(herder.firstName);
      } else if (mapOldListLastNames.keys.contains(herder.lastName)) {
        mapNewListLastNames.remove(herder.lastName);
      } else if (mapOldListLastNames.keys.contains(herder.bidon.toString())) {
        mapNewListBidon.remove(herder.bidon.toString());
      }
    }
    final _lastList = {
      ...mapNewListFirstNames,
      ...mapNewListLastNames,
      ...mapNewListBidon
    };
    return _oldList.followedBy(_lastList.values.toList()).toList();
  }

  List<Flock> preserveOldFlocksAndRemoveDuplicates(
      List<Flock> _oldList, List<Flock> _newList) {
    Map<String, Flock> mapOldList = {};
    for (var flock in _oldList) {
      mapOldList[flock.date.toString()] = flock;
    }
    Map<String, Flock> mapNewList = {};
    for (var flock in _newList) {
      mapNewList[flock.date.toString()] = flock;
    }
    for (var flock in _newList) {
      if (mapOldList.keys.contains(flock.date.toString())) {
        mapNewList.remove(flock.date.toString());
      }
    }
    return _oldList.followedBy(mapNewList.values.toList());
    // on peut même + tard identifier les éléments nouveaux et les doublons
  }

  @override
  Widget build(BuildContext context) {
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    final flocksStore = Provider.of<FlocksStore>(context, listen: false);
    final herdersStore = Provider.of<HerdersStore>(context);
    //final collectorStore = Provider.of<CollectorStore>(context);
    //final thiscollector = collectorStore.collector.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Importer des listes'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final isOkToErase = await showDialogImport(context);
                      if (!isOkToErase) {
                        return;
                      }
                      final file = await FilePicker.getFile(
                          type: FileType.custom, allowedExtensions: ['json']);
                      if (file == null) {
                        return;
                      }
                      /*  else if (collectorStore.collector.first.isLocked == true) {
                        return showDialogCSNotOk(
                            "Permission requise", context);
                      }  */
                      else {
                        final _importedCommoditiesString =
                            await file.readAsString();
                        var _oldList = commoditiesStore.commodities.toList();
                        var _newList = (convert.json
                                .decode(_importedCommoditiesString) as List)
                            .cast<Map>()
                            .cast<Map<String, dynamic>>()
                            .map((c) => Commodity.fromJson(c))
                            .toList();
                        final _updatedList =
                            preserveOldCommoditiesAndRemoveDuplicates(
                                _oldList, _newList);
                        await commoditiesStore.saveCommodities(_updatedList);
                        return showDialogCSOk(
                            "Import produits terminé", context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.widgets, color: Colors.orange[800]),
                        ),
                        Text(
                          'Importer le fichier .json \nsans effacer les anciens produits',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
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
                                    'Attention la suppression de l\'ancien catalogue pour importer le nouveau est irréversible. Êtes vous sur de vouloir continuer ?'),
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
                      final file = await FilePicker.getFile(
                          type: FileType.custom, allowedExtensions: ['json']);
                      if (file == null) {
                        return;
                        //} else if (thisCollector.isLocked == true) {
                        //  return showDialogWeebiNotOk(
                        //      'Permission requise', context);
                      } else {
                        final _products = await file.readAsString();
                        await commoditiesStore.deleteAllCommodities([]);
                        await commoditiesStore.importCatalogue(_products);
                        return showDialogCSOk(
                            'Ancien catalogue effacé. \nIimport du nouveau catalogue terminé',
                            context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.find_replace,
                              color: Colors.orange[800]),
                        ),
                        Text(
                          'Importer le fichier .json \nen effacant les anciens produits',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final isOkToErase = await showDialogImport(context);
                      if (!isOkToErase) {
                        return;
                      }
                      final file = await FilePicker.getFile(
                          type: FileType.custom, allowedExtensions: ['json']);
                      if (file == null) {
                        return;
                        // } else if (collectorStore.collector.first.isLocked) {
                        //   return showDialogWeebiNotOk(
                        //       "Permission requise", context);
                      } else {
                        final _importedHerdersString =
                            await file.readAsString();
                        var _oldList = herdersStore.herders.toList();
                        var _newList = (convert.json
                                .decode(_importedHerdersString) as List)
                            .cast<Map>()
                            .cast<Map<String, dynamic>>()
                            .map((herder) => Herder.fromJson(herder))
                            .toList();
                        final _updatedList =
                            preserveOldHerdersAndRemoveDuplicates(
                                _oldList, _newList);
                        await herdersStore.saveAllHerders(_updatedList);
                        return showDialogCSOk(
                            "Import contacts terminé", context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.contacts, color: Colors.blue[800]),
                        ),
                        Text(
                          'Importer le fichier .json \nsans effacer les anciens contacts',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        // if (thisCollector.isLocked == true) {
                        //   return showDialogCSNotOk("Permission requise", context);
                        // } else {
                        final isOkToErase = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (c) {
                            return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.warning, color: Colors.red),
                                  Text(
                                      'Attention l\'import va effacer les anciens contacts. Êtes-vous sur de vouloir continuer ?'),
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
                        final file = await FilePicker.getFile(
                            type: FileType.custom, allowedExtensions: ['json']);
                        if (file == null) {
                          return;
                        } else {
                          final _herders = await file.readAsString();
                          await herdersStore.importHerders(_herders);
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.find_replace,
                              color: Colors.blue[800],
                            ),
                          ),
                          Text(
                            'Importer le fichier .json \nen effacant les anciens contacts',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final isOkToErase = await showDialogImport(context);
                      if (!isOkToErase) {
                        return;
                      }
                      final file = await FilePicker.getFile(
                          type: FileType.custom, allowedExtensions: ['json']);
                      if (file == null) {
                        return;
                        // } else if (collectorStore.collector.first.isLocked == true) {
                        //   return showDialogWeebiNotOk(
                        //       "Permission requise", context);
                        //
                      } else {
                        final _importedFlocksString = await file.readAsString();
                        var _oldList = flocksStore.flocks.toList();
                        var _newList =
                            (convert.json.decode(_importedFlocksString) as List)
                                .cast<Map>()
                                .cast<Map<String, dynamic>>()
                                .map((flock) => Flock.fromJson(flock))
                                .toList();
                        final _updatedList =
                            preserveOldFlocksAndRemoveDuplicates(
                                _oldList, _newList);
                        await flocksStore.saveAllFlocks(_updatedList);
                        return showDialogCSOk(
                            "Import des collectes terminé", context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.receipt, color: Colors.grey[800]),
                        ),
                        Text(
                          'Importer le fichier .json \nsans effacer les anciennes collectes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final isOkToErase = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        builder: (c) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    'Attention l\'import des collectes va effacer toutes les anciennes opérations. \nÊtes vous VRAIMENT sur de vouloir continuer ?'),
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
                      final file = await FilePicker.getFile(
                          type: FileType.custom, allowedExtensions: ['json']);
                      if (file == null) {
                        return;
                        //} else if (thisCollector.isLocked == true) {
                        //  return showDialogWeebi('Permission requise', context);
                      } else {
                        final _flocks = await file.readAsString();
                        await flocksStore.importPastFlocks(_flocks);
                        return showDialogCSOk(
                            'Import des collectes terminé', context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.find_replace,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'Importer le fichier .json \nen effaçant les anciennes collectes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
