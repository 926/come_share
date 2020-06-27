import 'package:come_share/src/rpc/herder/get_herders.dart';
import 'package:come_share/src/rpc/herder/save_herders.dart';
import 'package:come_share/src/rpc/herder/update_herder.dart';
import 'package:come_share/src/rpc/herder/disable_herder.dart';
import 'package:come_share/src/rpc/herder/delete_herders.dart';
import 'package:come_share/src/rpc/herder/restore_herder.dart';
import 'package:come_share/src/rpc/herder/create_herder.dart';
import 'package:come_share/src/rpc/herder/delete_forever_herder.dart';

class HerdersService {
  final GetHerdersRpc getHerdersRpc;
  final SaveAllHerdersRpc saveAllHerdersRpc;
  final UpdateHerderRpc updateHerderRpc;
  final DisableHerderRpc disableHerderRpc;
  final DeleteAllHerdersRpc deleteAllHerdersRpc;
  final RestoreHerderRpc restoreHerderRpc;
  final CreateHerderRpc createHerderRpc;
  final DeleteForeverHerderRpc deleteForeverHerderRpc;

  HerdersService(
      this.getHerdersRpc,
      this.saveAllHerdersRpc,
      this.updateHerderRpc,
      this.disableHerderRpc,
      this.deleteAllHerdersRpc,
      this.restoreHerderRpc,
      this.createHerderRpc,
      this.deleteForeverHerderRpc);
}
