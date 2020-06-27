import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:come_share/src/rpc/flock/add_flock.dart';
import 'package:come_share/src/rpc/flock/disable_flock.dart';
import 'package:come_share/src/rpc/flock/get_flocks.dart';
import 'package:come_share/src/rpc/flock/restore_flock.dart';
import 'package:come_share/src/rpc/flock/save_flocks.dart';

final flockRpc = [
  ProxyProvider<sembast.Database, AddFlockRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? AddFlockRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, DisableFlockRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? DisableFlockRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, GetFlocksRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? GetFlocksRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, RestoreFlockRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? RestoreFlockRpc(database);
    },
  ),
  ProxyProvider<sembast.Database, SaveAllFlocksRpc>(
    update: (c, database, previousRpc) {
      return previousRpc ?? SaveAllFlocksRpc(database);
    },
  )
];
