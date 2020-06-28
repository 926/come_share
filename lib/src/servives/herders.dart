import 'package:come_share/src/rpc/herder/get_herders.dart';
import 'package:come_share/src/rpc/herder/save_herders.dart';
import 'package:come_share/src/rpc/herder/delete_herders.dart';

class HerdersService {
  final GetHerdersRpc getHerdersRpc;
  final SaveAllHerdersRpc saveAllHerdersRpc;
  final DeleteAllHerdersRpc deleteAllHerdersRpc;

  HerdersService(
    this.getHerdersRpc,
    this.saveAllHerdersRpc,
    this.deleteAllHerdersRpc,
  );
}
