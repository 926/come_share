import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/views/main_view/main_view.dart';
// import 'package:provider/provider.dart';
// import 'package:come_share/src/stores/commodities.dart';
// import 'package:come_share/src/stores/collector.dart';
// import 'package:come_share/src/stores/flocks.dart';
// import 'package:come_share/src/webhooks/status.dart';
// import 'package:come_share/src/webhooks/upload_commodities.dart';
// import 'package:come_share/src/webhooks/upload_flocks.dart';

class SyncView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigator;

  SyncView({@required this.mainNavigator});

  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView>
    with SingleTickerProviderStateMixin {
  // ? is this singleTick useful ?
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  bool submitting;
  List<Flock> dlFlocks;
  List<Herder> downloadedHerders;

  @override
  void initState() {
    super.initState();
    submitting = false;
  }

  @override
  Widget build(BuildContext context) {
    //final shopsStore = Provider.of<ShopStore>(context);
    //final flocksStore = Provider.of<FlocksStore>(context, listen: true);
    //final commoditiesStore = Provider.of<CommoditiesStore>(context, listen: true);
    //print('flocks length ${flocksStore.flocks.length}');
    return IgnorePointer(
      ignoring: submitting,
      child: MainView(
        selectedIndex: 3,
        actions: <Widget>[],
        mainNavigatorKey: widget.mainNavigator,
        body: Scaffold(
          key: _scaffoldKey,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: !submitting
                    ? Container()
                    : CircularProgressIndicator(
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 12,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    tooltip: 'Envoyer les données sur le serveur',
                    icon: Icon(Icons.cloud_upload, size: 63),
                    splashColor: Colors.red[800],
                    highlightColor: Colors.redAccent,
                    onPressed: () async {
                      var connectivityResult =
                          await Connectivity().checkConnectivity();
                      if (connectivityResult == ConnectivityResult.none) {
                        showDialogCSNotOk(
                            'Il n\'y a pas de connexion à internet', context);
                      } else if (connectivityResult ==
                              ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        setState(() {
                          submitting = true;
                        });
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Import en cours, fadagol ')));
                        try {
                          /* await uploadCommodities(shopsStore.shop.first.isProd,
                              commodities: commoditiesStore.commodities.toList());
                          List<Ticket> ticketsSell = ticketsStore.tickets
                              .where((t) => t.ticketType == TicketType.sell)
                              .toList();
                          print(
                              "creationDate ${ticketsSell.first.creationDate}");
                          UuidServiceStatus oasisIsGood =
                              await uploadTicketsStitch(
                                  shopsStore.shop.first.isProd,
                                  tickets: ticketsSell);
                          if (oasisIsGood == UuidServiceStatus.success) {
                            showDialogCSOk(
                                "Synchronisation sur le serveur terminée.",
                                context);
                          } else {
                            showDialogCSNotOk(
                                "Erreur lors de la synchronisation des données.",
                                context);
                          } */
                        } catch (e) {
                          showDialogCSNotOk(e.toString(), context);
                        }
                        setState(() {
                          submitting = false;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Envoyer les données sur le serveur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
