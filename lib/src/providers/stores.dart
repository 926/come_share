import 'package:come_share/src/servives/collector.dart';
import 'package:come_share/src/servives/commodities.dart';
import 'package:come_share/src/stores/collector.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/servives/flocks.dart';
import 'package:come_share/src/servives/herders.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/stores/app.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/stores/cart.dart';
import 'package:sembast/sembast.dart' as sembast;

class StoresProvider extends StatelessWidget {
  final Widget child;
  final sembast.Database database;

  StoresProvider({@required this.child, this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<FlocksService, FlocksStore>(
          update: (c, service, previousStore) {
            return previousStore ?? FlocksStore(database, service);
          },
        ),
        ProxyProvider<HerdersService, HerdersStore>(
          update: (c, service, previousStore) {
            return previousStore ?? HerdersStore(database, service);
          },
        ),
        ProxyProvider<CommoditiesService, CommoditiesStore>(
          update: (c, service, previousStore) {
            return previousStore ?? CommoditiesStore(database, service);
          },
        ),
        ProxyProvider<CollectorService, CollectorStore>(
          update: (c, service, previousStore) {
            return previousStore ?? CollectorStore(database, service);
          },
        ),
        ProxyProvider<CommoditiesStore, CartStore>(
          update: (c, commoditiesStore, previousStore) {
            return CartStore(commoditiesStore);
          },
        ),
        ProxyProvider4<FlocksStore, HerdersStore, CommoditiesStore,
            CollectorStore, AppStore>(
          update: (c, flocksStore, herdersStore, commoditiesStore,
              collectorStore, previousStore) {
            return previousStore ??
                AppStore(flocksStore, herdersStore, commoditiesStore,
                    collectorStore);
          },
        ),
      ],
      child: child,
    );
  }
}
