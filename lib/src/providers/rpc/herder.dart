import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/rpc/herder/delete_herders.dart';
import 'package:come_share/src/rpc/herder/get_herders.dart';
import 'package:come_share/src/rpc/herder/save_herders.dart';

final herderRpc = [
  ProxyProvider<sembast.Database, GetHerdersRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? GetHerdersRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, SaveAllHerdersRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? SaveAllHerdersRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, DeleteAllHerdersRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? DeleteAllHerdersRpc(database);
    },
  ),
];
