import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/views/main_view/herders/herder_detail.dart';

class HerderDetailRoute extends RcRoute {
  static String routePath = '/herders/:id';

  static String generateRoute(String id) =>
      RcRoute.generateRoute(routePath, pathParams: {'id': id});

  HerderDetailRoute() : super(path: HerderDetailRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<RcRouteParameters>(context);
    final herderId = routeParams.pathParameters['id'];
    final herdersStore = Provider.of<HerdersStore>(context);
    return Provider.value(
      value: herdersStore.herders
          .firstWhere((herder) => '${herder.id}' == herderId, orElse: null),
      child: HerderDetailWidget(
          herder: herdersStore.herders.firstWhere(
              (herder) => '${herder.id}' == herderId,
              orElse: () => herdersStore.herders.first)), // Preventing dirty red
    );
  }
}
