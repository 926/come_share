import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:come_share/src/views/commodities/lot_detail.dart';

class LotDetailRoute extends RcRoute {
  static String routePath = '/commodity/:commodityId/:lotId';

  static String generateRoute(String commodityId, String lotId) =>
      RcRoute.generateRoute(routePath,
          pathParams: {'commodityId': commodityId, 'lotId': lotId});

  LotDetailRoute() : super(path: LotDetailRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<RcRouteParameters>(context);
    final commodityId = routeParams.pathParameters['commodityId'];
    final lotId = routeParams.pathParameters['lotId'];
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    final _commodity = commoditiesStore.commodities
        .firstWhere((p) => p.id?.toString() == commodityId, orElse: null);
    return Provider.value(
      value: _commodity.lots
          .firstWhere((l) => l.id?.toString() == lotId, orElse: null),
      child: LotDetailWidget(
        lot: _commodity.lots
            .firstWhere((l) => l.id?.toString() == lotId, orElse: null),
      ),
    );
  }
}
