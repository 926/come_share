import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/rpc/collector/get_collector.dart';

final collectorRpc = [
  ProxyProvider<sembast.Database, GetCollectorRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? GetCollectorRpc(database);
    },
  ),
];
