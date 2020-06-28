import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/rpc/herder/delete_herders.dart';
import 'package:come_share/src/rpc/herder/get_herders.dart';
import 'package:come_share/src/rpc/herder/save_herders.dart';
import 'package:come_share/src/rpc/flock/add_flock.dart';
import 'package:come_share/src/rpc/flock/disable_flock.dart';
import 'package:come_share/src/rpc/flock/restore_flock.dart';
import 'package:come_share/src/rpc/flock/get_flocks.dart';
import 'package:come_share/src/rpc/flock/save_flocks.dart';
import 'package:come_share/src/rpc/commodity/get_commodities.dart';
import 'package:come_share/src/rpc/commodity/save_commodities.dart';
import 'package:come_share/src/servives/flocks.dart';
import 'package:come_share/src/servives/herders.dart';
import 'package:come_share/src/servives/commodities.dart';

class ServicesProvider extends StatelessWidget {
  final Widget child;

  ServicesProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider3<GetHerdersRpc, SaveAllHerdersRpc, DeleteAllHerdersRpc,
            HerdersService>(
          update: (c, getHerdersRpc, saveAllHerdersRpc, deleteAllHerdersRpc,
              previousService) {
            return previousService ??
                HerdersService(
                  getHerdersRpc,
                  saveAllHerdersRpc,
                  deleteAllHerdersRpc,
                );
          },
        ),
        ProxyProvider5<AddFlockRpc, DisableFlockRpc, GetFlocksRpc,
            RestoreFlockRpc, SaveAllFlocksRpc, FlocksService>(
          update: (c, addFlockRpc, disableFlockRpc, getFlocksRpc,
              restoreFlocksRpc, saveAllFlocksRpc, previousService) {
            return previousService ??
                FlocksService(addFlockRpc, disableFlockRpc, getFlocksRpc,
                    restoreFlocksRpc, saveAllFlocksRpc);
          },
        ),
        ProxyProvider2<GetCommoditiesRpc, SaveAllCommoditiesRpc,
            CommoditiesService>(
          update:
              (c, getCommoditiesRpc, saveAllCommoditiesRpc, previousService) {
            return previousService ??
                CommoditiesService(getCommoditiesRpc, saveAllCommoditiesRpc);
          },
        ),
      ],
      child: child,
    );
  }
}
