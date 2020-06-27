import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/rpc/herder/create_herder.dart';
import 'package:come_share/src/rpc/herder/delete_forever_herder.dart';
import 'package:come_share/src/rpc/herder/delete_herders.dart';
import 'package:come_share/src/rpc/herder/disable_herder.dart';
import 'package:come_share/src/rpc/herder/get_herders.dart';
import 'package:come_share/src/rpc/herder/restore_herder.dart';
import 'package:come_share/src/rpc/herder/save_herders.dart';
import 'package:come_share/src/rpc/herder/update_herder.dart';

final herderRpc = [
  ProxyProvider<sembast.Database, CreateHerderRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? CreateHerderRpc(database);
    },
  ),
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
  ProxyProvider<sembast.Database, UpdateHerderRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? UpdateHerderRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, DisableHerderRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? DisableHerderRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, DeleteAllHerdersRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? DeleteAllHerdersRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, RestoreHerderRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? RestoreHerderRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, DeleteForeverHerderRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? DeleteForeverHerderRpc(database);
    },
  ),
];
