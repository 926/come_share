import 'package:putu_putu/src/routes/commodities/commodity_detail.dart';
import 'package:putu_putu/src/stores/flocks.dart';
import 'package:flutter/material.dart';
import 'package:putu_putu/src/models/lot.dart';
import 'package:putu_putu/src/utils/formatters.dart';
import 'package:provider/provider.dart';
//import 'package:putu_putu/src/stores/collector.dart';
//import 'package:provider/provider.dart';

class LotDetailWidget extends StatefulWidget {
  final Lot lot;

  LotDetailWidget({@required this.lot});

  @override
  _LotDetailWidgetState createState() => _LotDetailWidgetState();
}

class _LotDetailWidgetState extends State<LotDetailWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final collectorStore = Provider.of<CollectorStore>(context);
    // final thisCollector = collectorStore.collector.first;

    final flocksStore = Provider.of<FlocksStore>(context);
    final _lotQtIn = flocksStore.lotQuantityIn(widget.lot);
    //final _commodityQtOut = flocksStore.commodityQuantityOut(widget.commodity);

    return WillPopScope(
      onWillPop: () async => Navigator.of(context).popAndPushNamed(
          CommodityDetailRoute.generateRoute('${widget.lot.commodityId}')),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          leading: Builder(
            builder: (BuildContext c) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pushNamed(
                    CommodityDetailRoute.generateRoute(
                        '${widget.lot.commodityId}')),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text("Fiche Lot"),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF20272B), Colors.white],
                      begin: Alignment.bottomCenter,
                      end: Alignment(0.0, 1),
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.check_box_outline_blank),
                            ],
                          ),
                        ),
                        Text(
                          "Numéro : ",
                        ),
                        Text(
                          "${widget.lot.commodityId}.${widget.lot.id}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.opacity,
                                  color: Colors
                                      .black // if quantity > 0 => Icons.hourglass_empty
                                  ),
                            ],
                          ),
                        ),
                        Text(
                          "Quantité : ",
                        ),
                        Text(
                          "${numberFormatter?.format(_lotQtIn ?? 0.0)}", // TODO get lot full qt
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons
                                    .settings, // if widget.lot.isDefault == false => Icons.device_hub
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Lot par défaut : ",
                          style: TextStyle(),
                        ),
                        Text(
                          widget.lot.isDefault == true ? 'oui' : 'non',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    /* Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.event, color: Colors.black),
                            ],
                          ),
                        ),
                        Text(
                          "Date limite de consommation : ",
                        ),
                        Text(
                          "${widget.lot?.dlc}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    */
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.event, color: Colors.black),
                            ],
                          ),
                        ),
                        Text(
                          "Date de création : ",
                        ),
                        Expanded(
                          child: Text(
                            "${widget.lot?.lotDate.toString().substring(0, 19)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
