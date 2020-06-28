import 'package:come_share/src/views/main_view/commodities/elements/lot_element.dart';
import 'package:flutter/material.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/routes/commodities/commodities.dart';
//import 'package:provider/provider.dart';
//import 'package:come_share/src/stores/collector.dart';
//import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/utils/formatters.dart';

class CommodityDetailWidget extends StatefulWidget {
  final Commodity commodity;

  CommodityDetailWidget({@required this.commodity});

  @override
  _CommodityDetailWidgetState createState() => _CommodityDetailWidgetState();
}

class _CommodityDetailWidgetState extends State<CommodityDetailWidget> {
  bool commodityStatus;

  @override
  void initState() {
    super.initState();
    commodityStatus = widget.commodity.status;
  }


  Gradient getcommodityGradient(bool widgetcommodityStatus) {
    if (widgetcommodityStatus == true) {
      return LinearGradient(
          colors: [Colors.grey[100], Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment(0.0, 0.9),
          tileMode: TileMode.clamp);
    } else {
      return LinearGradient(
          colors: [Colors.orange[900], Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment(0.0, 0.9),
          tileMode: TileMode.clamp);
    }
  }

  Color getcommodityStatusColor(bool widgetcommodityStatus) {
    if (widgetcommodityStatus == true) {
      return Colors.teal;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final collectorStore = Provider.of<CollectorStore>(context);
    // final thisCollector = collectorStore.collector.first;

    return WillPopScope(
      onWillPop: () async =>
          Navigator.of(context).popAndPushNamed(CommoditiesRoute.routePath),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CommoditiesRoute.routePath);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            'Fiche Produit',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: getcommodityGradient(commodityStatus),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          widget.commodity.photo != '' &&
                                  widget.commodity?.photo != null
                              ? Container(
                                  width: 180,
                                  height: 180,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/photos/${widget.commodity.photo}')))
                              : Container(),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.dialpad,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Numéro : ",
                                  style: TextStyle(),
                                ),
                              ),
                              Text(
                                "${widget.commodity.id}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.short_text, color: Colors.black),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Titre : ",
                                ),
                              ),
                              Text(
                                "${widget.commodity.name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.straighten, color: Colors.black),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Unité : ",
                                  style: TextStyle(),
                                ),
                              ),
                              Text(
                                "${widget.commodity.stockUnitText}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          widget.commodity?.status == false
                              ? Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.speaker_phone,
                                              color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Produit désactivé le : ",
                                        style: TextStyle(),
                                      ),
                                    ),
                                    Text(
                                      "${widget.commodity?.statusUpdateDate}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : Container(),
                          Divider(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.format_list_numbered,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Nombre de lots : ",
                                  style: TextStyle(),
                                ),
                              ),
                              Text(
                                "${widget.commodity.lots.length}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      commodityStatus == true
                                          ? Icons.widgets
                                          : Icons.hourglass_empty,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Stock produit: ",
                                ),
                              ),
                              Text(
                                '${numberFormatter.format(widget.commodity.lots.fold(0, (lotValue, lot) => lotValue + lot.quantity))}',
                                style: commodityStatus == true
                                    ? TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                commodityStatus == true
                                    ? ''
                                    : '   (alerte envoyée)',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommodityList(
                    commodity: widget.commodity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommodityList extends StatelessWidget {
  final Commodity commodity;

  CommodityList({@required this.commodity});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          for (final lovingLot in commodity.lots)
            LotItemWidget(
              commodity: commodity,
              lot: lovingLot,
            )
        ],
      ),
    );
  }
}
