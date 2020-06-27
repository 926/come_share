import 'package:come_share/src/servives/commodities.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/servives/flocks.dart';
import 'package:come_share/src/servives/herders.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/stores/app.dart';
import 'package:come_share/src/stores/flocks.dart';

class StoresProvider extends StatelessWidget {
  final Widget child;

  StoresProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<FlocksService, FlocksStore>(
          update: (c, service, previousStore) {
            return previousStore ?? FlocksStore(service);
          },
        ),
        ProxyProvider<HerdersService, HerdersStore>(
          update: (c, service, previousStore) {
            return previousStore ?? HerdersStore(service);
          },
        ),
        ProxyProvider<CommoditiesService, CommoditiesStore>(
          update: (c, service, previousStore) {
            return previousStore ?? CommoditiesStore(service);
          },
        ),
        ProxyProvider3<FlocksStore, HerdersStore, CommoditiesStore, AppStore>(
          update: (c, flocksStore, herdersStore, productsStore, previousStore) {
            return previousStore ??
                AppStore(
                  flocksStore,
                  herdersStore,
                  productsStore,
                );
          },
        ),
      ],
      child: child,
    );
  }
}
