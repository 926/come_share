import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/stores/commodities.dart';
import 'package:come_share/src/views/main_view/commodities/commodity_detail.dart';

class CommodityDetailRoute extends RcRoute {
  static String routePath = '/commodity/:id';

  static String generateRoute(String id) =>
      RcRoute.generateRoute(routePath, pathParams: {'id': id});

  CommodityDetailRoute() : super(path: CommodityDetailRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<RcRouteParameters>(context);
    final commodityId = routeParams.pathParameters['id'];
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    return Provider.value(
      value: commoditiesStore.commodities
          .firstWhere((c) => '${c.id}' == commodityId, orElse: null),
      child: CommodityDetailWidget(
          commodity: commoditiesStore.commodities
              .firstWhere((c) => '${c.id}' == commodityId, orElse: null)),
    );
  }
}
