import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/rpc/commodity/get_commodities.dart';
import 'package:come_share/src/rpc/commodity/save_commodities.dart';

final commodityRpc = [
  ProxyProvider<sembast.Database, GetCommoditiesRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? GetCommoditiesRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, SaveAllCommoditiesRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? SaveAllCommoditiesRpc(database);
    },
  ),
];
