import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;

import 'package:putu_putu/src/stores/collector.dart';
import 'package:putu_putu/src/stores/commodities.dart';
import 'package:putu_putu/src/stores/herders.dart';
import 'package:putu_putu/src/stores/app.dart';
import 'package:putu_putu/src/stores/flocks.dart';
import 'package:putu_putu/src/stores/cart.dart';

class StoresProvider extends StatelessWidget {
  final Widget child;
  final sembast.Database database;

  StoresProvider({@required this.child, this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlocksStore>(
          create: (_) => FlocksStore(database),
        ),
        Provider<HerdersStore>(
          create: (_) {
            return HerdersStore(database);
          },
        ),
        Provider<CommoditiesStore>(
          create: (_) {
            return CommoditiesStore(database);
          },
        ),
        Provider<CollectorStore>(
          create: (_) {
            return CollectorStore(database);
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
              collectorStore, appStore) {
            return appStore ??
                AppStore(flocksStore, herdersStore, commoditiesStore,
                    collectorStore);
          },
        ),
      ],
      child: child,
    );
  }
}
