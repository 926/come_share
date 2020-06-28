import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
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

  Future<Flock> _onDisable(Flock flockToDisable) async {
    final flockStore = Provider.of<FlocksStore>(context, listen: false);
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    for (final item in flockToDisable.items) {
      await commoditiesStore.disableLotDouble(item.lot, item.quantity);
    }
    final disableingTicket = await flockStore.disableFlock(flockToDisable);
    return disableingTicket;
  }

  Future<Flock> _onRestore(Flock flockToRestore) async {
    final flockStore = Provider.of<FlocksStore>(context, listen: false);
    final commoditiesStore =
        Provider.of<CommoditiesStore>(context, listen: false);
    for (final item in flockToRestore.items) {
      await commoditiesStore.removeLotDouble(item.lot,
          item.quantity); // if bigQuantity then there can be only be a single item.lot

    }
    final restoringTicket = await flockStore.restoreFlock(flockToRestore);
    return restoringTicket;
  }

  @override
  Widget build(BuildContext context) {
    final flock = Provider.of<Flock>(context, listen: true);
    //final collectorStore = Provider.of<CollectorStore>(context);
    //final thiscollector = collectorStore.shop.first;

    return Scaffold(
      floatingActionButton: Stack(
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
                            awkwardUncleDrunkAndNakedAtChristmasTicket.status;
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

                      //_restoreBottomSheet(context);
                    }),
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
    final flock = Provider.of<Flock>(context, listen: true);
    //final collectorStore = Provider.of<CollectorStore>(context, listen: false);
    //final thisCollector = collectorStore.collector.first;

    final herdersStore = Provider.of<HerdersStore>(context, listen: false);
    Herder thisHerder = herdersStore.herders.firstWhere(
        (h) => h.id.toString() == flock.herderId,
        orElse: () => herdersStore.herders.first);
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text('Detail du ticket'),
    );
  }

  PreferredSizeWidget _appBarFalse() {
    //final ticket = Provider.of<Ticket>(context, listen: true);
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
