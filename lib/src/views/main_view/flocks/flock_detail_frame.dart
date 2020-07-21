import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/views/main_view/flocks/flock_detail.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/stores/commodities.dart';
//import 'package:come_share/src/stores/collector.dart';

class FlockDetailFrame extends StatefulWidget {
  final Flock flock;

  FlockDetailFrame({@required this.flock});

  @override
  _FlocktDetailFrameState createState() => _FlocktDetailFrameState();
}

class _FlocktDetailFrameState extends State<FlockDetailFrame> {
  bool flockStatus;

  @override
  void initState() {
    super.initState();
    flockStatus = widget.flock.status;
  }

  Future<Flock> _onDisable(Flock thisFlock) async {
    final soonToBeDisabledFlock = Flock(
      key: thisFlock.key,
      axeUuid: thisFlock?.axeUuid ?? '0',
      items: thisFlock.items,
      comment: thisFlock.comment,
      received: thisFlock.received,
      date: thisFlock.date,
      creationDate: thisFlock.creationDate,
      flockType: thisFlock.flockType,
      herderId: thisFlock.herderId,
      status: false,
      statusUpdateDate: DateTime.now(),
    );
    final flockStore = Provider.of<FlocksStore>(context, listen: false);
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    for (final item in soonToBeDisabledFlock.items) {
      await commoditiesStore.disableLotDouble(item.lot, item.quantity);
    }
    final disableingTicket =
        await flockStore.disableFlock(soonToBeDisabledFlock);
    return disableingTicket;
  }

  Future<Flock> _onRestore(Flock thisFlock) async {
    final soonToBeRestoredFlock = Flock(
      key: thisFlock.key,
      axeUuid: thisFlock?.axeUuid ?? '0',
      items: thisFlock.items,
      comment: thisFlock.comment,
      received: thisFlock.received,
      date: thisFlock.date,
      creationDate: thisFlock.creationDate,
      flockType: thisFlock.flockType,
      herderId: thisFlock.herderId,
      status: true,
      statusUpdateDate: DateTime.now(),
    );
    final flockStore = Provider.of<FlocksStore>(context, listen: false);
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    for (final item in soonToBeRestoredFlock.items) {
      await commoditiesStore.removeLotDouble(item.lot, item.quantity);
    }
    final restoringTicket =
        await flockStore.restoreFlock(soonToBeRestoredFlock);
    return restoringTicket;
  }

  @override
  Widget build(BuildContext context) {
    final flock = Provider.of<Flock>(context, listen: true);
    //final collectorStore = Provider.of<CollectorStore>(context);
    //final thiscollector = collectorStore.shop.first;

    return Scaffold(
      floatingActionButton: 'settingsBool' ==
              'settingsBool' // user permission disabled by default
          ? Container()
          : Stack(
              children: <Widget>[
                if (flockStatus == true)
                  Padding(
                    padding: EdgeInsets.only(left: 31),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        heroTag: 1,
                        tooltip: "Désactiver le ticket",
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            final awkwardUncleDrunkAndNakedAtChristmasTicket =
                                await _onDisable(widget.flock);
                            setState(() {
                              flockStatus =
                                  awkwardUncleDrunkAndNakedAtChristmasTicket
                                      .status;
                            });
                          } catch (e) {
                            print('$e');
                          }
                        },
                      ),
                    ),
                  ),
                if (flockStatus == false)
                  Padding(
                    padding: EdgeInsets.only(right: 31),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        heroTag: 2,
                        child: Icon(Icons.restore_from_trash),
                        onPressed: () async {
                          try {
                            final fakeGanstaRapWithGoldenChainTicket =
                                await _onRestore(widget.flock);
                            setState(() {
                              flockStatus = fakeGanstaRapWithGoldenChainTicket
                                  .status; // not sure this is enough to rebuild the whole
                            });
                          } catch (e) {
                            print('$e');
                          }
                        },
                      ),
                    ),
                  )
              ],
            ),
      appBar: flockStatus == true ? _appBarTrue() : _appBarFalse(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlockDetailWidget(
          flock: flock,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarTrue() {
    return AppBar(
      title: Text('Detail du reçu'),
      backgroundColor: Colors.blueGrey,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBarFalse() {
    //final ticket = Provider.of<Ticket>(context, listen: true);
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text('Collecte désactivée'),
      backgroundColor: Colors.grey[800],
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            //Share.share(ticket.sharableText);
          },
        ),
      ],
    );
  }
}
