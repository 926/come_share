import 'package:come_share/src/rpc/commodity/get_commodities.dart';
import 'package:come_share/src/rpc/commodity/save_commodities.dart';

class CommoditiesService {
  final GetCommoditiesRpc getCommoditiesRpc;
  final SaveAllCommoditiesRpc saveAllCommoditiesRpc;

  CommoditiesService(this.getCommoditiesRpc, this.saveAllCommoditiesRpc);
}
