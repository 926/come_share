//import 'dart:async';

import 'package:come_share/src/views/main_view/flocks/flock_overview.dart';
import 'package:flutter/material.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/routes/herders/herders.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/utils/formatters.dart';
//import 'package:come_share/src/stores/collector.dart';
//import 'package:come_share/src/views/main_view/flocks/flock_overview.dart';

class HerderDetailWidget extends StatefulWidget {
  final Herder herder;

  HerderDetailWidget({@required this.herder});

  @override
  _HerderDetailWidgetState createState() => _HerderDetailWidgetState();
}

class _HerderDetailWidgetState extends State<HerderDetailWidget> {
  bool herderStatus;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    herderStatus = widget.herder.status;
  }

  String makeItPretty(Map<String, Herder> map) {
    var ff;
    List<String> reversedList = [];

    map.forEach((key, value) {
      reversedList.add(numberFormatter.format(int.parse(key)));
    });
    ff = reversedList.toString().replaceAll('[', '').replaceAll(']', '');
    return ff;
  }

  Widget build(BuildContext context) {
    //final shopStore = Provider.of<ShopStore>(context);
    //final thisShop = shopStore.shop.first;

    return WillPopScope(
      onWillPop: () async =>
          Navigator.of(context).popAndPushNamed(HerdersRoute.routePath),
      child: Scaffold(
        key: _scaffoldKey, // avoiding scaffold.of error
        appBar: herderStatus == true ? _appBarTrue() : _appBarFalse(),
        body: // TOBE make below a ContactWidget just like ticket
            Column(
          children: <Widget>[
            Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue[700]],
                        begin: Alignment.bottomCenter,
                        end: Alignment(0.0, 0.9),
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.portrait, color: Colors.white),
                                ],
                              ),
                            ),
                            Text(
                              '${widget.herder.firstName} ${widget.herder.lastName}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        widget.herder.tel == null
                            ? Container()
                            : widget.herder.tel.isEmpty
                                ? Container()
                                : Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "téléphone : ${widget.herder.tel}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                        widget.herder.mail == null || widget.herder.mail.isEmpty
                            ? Container()
                            : Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.alternate_email,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "mail : ${widget.herder.mail}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                        widget.herder.address == null ||
                                widget.herder.address.isEmpty
                            ? Container()
                            : Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_city,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "adresse : ${widget.herder.address}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: HerderFlocksList(
                herder: widget.herder,
              ),
            ),
            ListTile(), // just to prevent FAB from overlapping the first item
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarTrue() {
    //final shopStore = Provider.of<CollectorStore>(context);
    //final thisShop = shopStore.shop.first;
    return AppBar(
      backgroundColor: Colors.blue[800],
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(HerdersRoute.routePath);
            },
          );
        },
      ),
      title: Text('bid : ${widget.herder.bidon}'),
      actions: <Widget>[],
    );
  }

  PreferredSizeWidget _appBarFalse() {
    // final collectorStore = Provider.of<CollectorStore>(context);
    // final thisCollector = collectorStore.shop.first;
    return AppBar(
      backgroundColor: Colors.grey[800],
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed(HerdersRoute.routePath);
            },
          );
        },
      ),
      title: Text('bidon : ${widget.herder.bidon}'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            if (widget.herder.id == 0) {
              return showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  return Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Contact verrouillé, ne peut être édité'),
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('ok'),
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
            } else {
              return {};
            }
          },
        ),
      ],
    );
  }
}

class HerderFlocksList extends StatelessWidget {
  final Herder herder;

  HerderFlocksList({@required this.herder});

  @override
  Widget build(BuildContext context) {
    final flocksStore = Provider.of<FlocksStore>(context, listen: false);
    var herderFlockss =
        flocksStore.flocks.where((t) => t.herderId == herder.id.toString());

    return Scrollbar(
      child: ListView(
        reverse: true,
        shrinkWrap: true,
        children: <Widget>[
          for (final flock in herderFlockss)
            FlockOverviewWidget(
              flock: flock,
            )
        ],
      ),
    );
  }
}
