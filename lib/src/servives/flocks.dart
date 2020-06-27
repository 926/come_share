import 'package:come_share/src/rpc/flock/add_flock.dart';
import 'package:come_share/src/rpc/flock/disable_flock.dart';
import 'package:come_share/src/rpc/flock/get_flocks.dart';
import 'package:come_share/src/rpc/flock/restore_flock.dart';
import 'package:come_share/src/rpc/flock/save_flocks.dart';

class FlocksService {
  final AddFlockRpc addFlockRpc;
  final DisableFlockRpc disableFlockRpc;
  final GetFlocksRpc getFlocksRpc;
  final RestoreFlockRpc restoreFlockRpc;
  final SaveAllFlocksRpc saveAllFlocksRpc;

  FlocksService(this.addFlockRpc, this.disableFlockRpc, this.getFlocksRpc,
      this.restoreFlockRpc, this.saveAllFlocksRpc);
}
