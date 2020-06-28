import 'dart:async';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/routes/herders/herder_detail.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/stores/cart.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/utils/formatters.dart';

import 'collect.dart';
//import 'package:come_share/src/stores/collector.dart';

class HerderCollectView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigatorKey;
  //final Future<void> Function(Flock flock) onSubmit;

  HerderCollectView({
    this.mainNavigatorKey,
    //@required this.onSubmit
  });

  @override
  _HerderCollectViewState createState() => _HerderCollectViewState();
}

class _HerderCollectViewState extends State<HerderCollectView> {
  List<Herder> herders;
  Herder selectedHerder;
  bool isSelectedHerder = true;
  List<Herder> _searchResults;
  bool _activeSearchByBidon;
  bool _activeSearchByQr;
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
    _activeSearchByBidon = false;
    _activeSearchByQr = false;
  }

  void _searchByQr(String queryString) {
    final herdersStore = Provider.of<HerdersStore>(context);
    List<Herder> searching = herdersStore.searchHerderByQr(queryString);

    setState(() {
      _searchResults = searching;
      _activeSearchByQr = true;
      _activeSearchByBidon = false;
    });
  }

  void _searchByBidon(String queryString) {
    final herdersStore = Provider.of<HerdersStore>(context);
    var temp = herdersStore.herders.where((h) {
      return h.bidon.toString().contains(queryString) ||
          h.firstName.toLowerCase().contains(queryString.toLowerCase()) ||
          h.lastName.toLowerCase().contains(queryString.toLowerCase());
    }).toList();
    setState(() {
      _searchResults = temp;
      _activeSearchByBidon = true;
      _activeSearchByQr = false;
    });
  }

  void setSelectedHerder(Herder val) {
    setState(() {
      selectedHerder = val;
      isSelectedHerder = false;
    });
  }

  void setIsSelectedHerder(bool val) {
    setState(() {
      isSelectedHerder = true;
      selectedHerder = null;
    });
  }

  Future<void> _onSubmit() async {
    final cartStore = Provider.of<CartStore>(context, listen: false);
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    final flocksStore = Provider.of<FlocksStore>(context, listen: false);

    final flockManager = Provider.of<FlockManager>(context);
    final flock = Flock(
        axeUuid: 'test',
        items: cartStore.items,
        comment: cartStore?.comment ?? '',
        received: 0,
        date: DateTime.now(),
        flockType: FlockType.gathered,
        herderId:
            '${cartStore?.herder?.id ?? 0}', // if no herder then use default
        status: true,
        statusUpdateDate: DateTime.now(),
        creationDate: DateTime.now());

    for (final item in cartStore.items) {
      print('we are in view, show me the lot : ${item.lot} ${item.quantity}');
      await commoditiesStore.removeLotDouble(
        item.lot,
        item.quantity,
      );
    }
    final coolFlock = await flocksStore.addFlock(flock);

    cartStore.clearItems();
    cartStore.clearComment(); // idem
    cartStore.removeAllBigQuantities();

    flockManager.flock = coolFlock;
    final collectorViewManager = Provider.of<CollectorViewsManager>(context);
    collectorViewManager.activeView = CollectorViews.validation;
  }

  @override
  Widget build(BuildContext context) {
    final herdersStore = Provider.of<HerdersStore>(context);
    final cartStore = Provider.of<CartStore>(context, listen: false);

    print(cartStore.items.length);
    print(cartStore.items.first.quantity);
//  final collectorStore = Provider.of<CollectorStore>(context);

    // ? select default herder on init
    // var clientHerder = herdersStore.herders.firstWhere((f) => f.id == 0, orElse: null);
    return Scaffold(
      appBar: AppBar(
          leading: _activeSearchByBidon == false
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => setState(() {
                    _activeSearchByBidon = true;
                  }),
                )
              : Container(),
          actions: <Widget>[
            !_activeSearchByBidon
                ? Container()
                : Flexible(
                    flex: 1,
                    child: ListTile(
                      leading: Icon(Icons.search, color: Colors.white),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () => setState(() {
                          _activeSearchByBidon = false;
                        }),
                      ),
                      title: TextField(
                        autofocus: true,
                        onChanged: (value) {
                          _searchByBidon(value);
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        onTap: () => setState(() =>
                            _activeSearchByBidon = true), // really useful ?
                        decoration: InputDecoration(
                          hintText: "n° bidon ou nom ou prénom",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
          ]),
      body: Column(
        children: <Widget>[
          // Text(_scanBarcode),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Text('Total quantité'),
                ),
                Observer(
                  builder: (context) => Text(
                    numberFormatter.format(cartStore.qt),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    //color: Colors.white,
                  ),
                  onPressed: () {
                    cartStore.clearItems();
                  },
                )
              ],
            ),
          ),
          if (_activeSearchByBidon == false && _activeSearchByQr == false ||
              _searchResults == null)
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: herdersStore.herders.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildBody(context, index),
                ),
              ),
            )
          else if (_activeSearchByQr == true && _searchResults != null)
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildSearchBody(context, index),
                ),
              ),
            )
          else
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildSearchBody(context, index),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 2,
              backgroundColor: Colors.teal,
              child: Text('OK'),
              onPressed: () {
                //final collectorStore = Provider.of<CollectorStore>(context);
                final cartStore = Provider.of<CartStore>(context);
                if (cartStore.items.isEmpty) {
                  showDialogCSNotOk('Panier vide', context);
                } else {
                  _onSubmit();
                }
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 106,
            child: _scanBarcode == null || _scanBarcode.isEmpty
                ? FloatingActionButton(
                    child: Icon(Icons.speaker_phone),
                    onPressed: () async {
                      await scanQr();
                      if (_scanBarcode != null && _scanBarcode.isNotEmpty)
                        await selectScannedHerderToCart(_scanBarcode);
                      setState(() {
                        _searchByQr(_scanBarcode);
                      }); // not working
                    },
                    backgroundColor: Color(0xFF1ac6ff),
                    heroTag: 99)
                : FloatingActionButton(
                    mini: true,
                    heroTag: 104,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      setState(() {
                        _scanBarcode = '';
                        _activeSearchByQr = false;
                        selectedHerder = herdersStore.herders
                            .firstWhere((element) => element.id == 0);
                        isSelectedHerder = false;
                        if (cartStore.herder != null) {
                          cartStore.clearHerder();
                        }
                      });
                    },
                    child: Icon(Icons.settings_backup_restore),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 106,
            child: isSelectedHerder
                ? Container()
                : cartStore?.herder != null && cartStore?.herder?.id != 0
                    ? FloatingActionButton(
                        backgroundColor: Colors.red[800],
                        heroTag: 1,
                        onPressed: () {
                          setState(() {
                            isSelectedHerder = false;
                            selectedHerder = null;
                            _activeSearchByQr = false;
                            _scanBarcode = '';
                          });
                          if (cartStore.herder != null) {
                            cartStore.clearHerder();
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Text("${cartStore?.herder?.bidon}"),
                            Icon(Icons.cancel),
                          ],
                        ))
                    : Container(),
          ),
        ],
      ),
    );
  }

  Future<void> scanQr() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#1ac6ff", "Annuler", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> selectScannedHerderToCart(String scannedQr) async {
    if (scannedQr != null) {
      final herdersStore = Provider.of<HerdersStore>(context);
      var _herder = herdersStore.herders?.firstWhere(
          (h) => h.qrcode == scannedQr,
          orElse: () =>
              herdersStore.herders.firstWhere((element) => element.id == 0));
      if (_herder != null) {
        final cartStore = Provider.of<CartStore>(context, listen: false);
        cartStore.setHerder(_herder);
        setSelectedHerder(_herder);
      }
    }
  }

  Widget buildBody(BuildContext context, int index) {
    final herdersStore = Provider.of<HerdersStore>(context);
    // final collectorStore = Provider.of<CollectorStore>(context);
    // final thisCollector = collectorStore.collector.first;
    return InkWell(
      onLongPress: () {
        Navigator.of(widget.mainNavigatorKey.currentContext).pushNamed(
            HerderDetailRoute.generateRoute(
                '${herdersStore.herders[index].id}'));
      },
      child: RadioListTile(
        isThreeLine: true,
        title: Text(
            '${herdersStore.herders[index]?.firstName} ${herdersStore.herders[index]?.lastName}' ??
                "noName"),
        subtitle: Text('hello'),
        // subtitle: Text(
        //     'bidon : ${herdersStore?.herders[index]?.bidon.toString()}' +
        //                 herdersStore?.herders[index]?.tel !=
        //             null
        //         ? 'tel : ${herdersStore?.herders[index]?.tel}'
        //         : ''),
        value: herdersStore.herders[index],
        groupValue: selectedHerder,
        onChanged: (currentHerder) {
          if (currentHerder.status != false) {
            setSelectedHerder(currentHerder);
          } else {
            showDialogCS(
                'Ce compte a été désactivé le ${currentHerder.statusUpdateDate}\n(bidon : ${currentHerder.bidon})',
                context);
            return;
          }
          setSelectedHerder(currentHerder);
          final cartStore = Provider.of<CartStore>(context, listen: false);
          if (selectedHerder != null) {
            cartStore.setHerder(selectedHerder);
          } // si le contact est sélectionné on le passe dans le cart
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Colors.teal,
      ),
    );
  }

  Widget buildSearchBody(BuildContext context, int index) {
    return InkWell(
      onLongPress: () {
        Navigator.of(widget.mainNavigatorKey.currentContext).pushNamed(
            HerderDetailRoute.generateRoute('${_searchResults[index].id}'));
      },
      child: RadioListTile(
        subtitle: Text(_searchResults[index].bidon.toString() ?? "noBid"),
        title: Text(
            '${_searchResults[index]?.firstName} ${_searchResults[index]?.firstName}' ??
                "noName"),
        value: _searchResults[index],
        groupValue: selectedHerder,
        onChanged: (currentHerder) {
          if (currentHerder.status != false) {
            setSelectedHerder(currentHerder);
          } else {
            showDialogCS(
                'Le compte été désactivé le ${currentHerder.statusUpdateDate}\n(bidon : ${currentHerder.bidon})',
                context);
            return;
          }
          setSelectedHerder(currentHerder);
          final cartStore = Provider.of<CartStore>(context, listen: false);
          if (selectedHerder != null) {
            cartStore.setHerder(selectedHerder);
          } // si le contact est sélectionné on le passe dans le cart
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Colors.teal,
      ),
    );
  }
}
