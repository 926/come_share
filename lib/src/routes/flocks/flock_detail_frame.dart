import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/views/flocks/flock_detail_frame.dart';

class FlockDetailRoute extends RcRoute {
  static String routePath = '/tickets/:id';

  static String generateRoute(String id) =>
      RcRoute.generateRoute(routePath, pathParams: {'id': id});

  FlockDetailRoute() : super(path: FlockDetailRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<RcRouteParameters>(context);
    final flockId = routeParams.pathParameters['id'];
    final flocksStore = Provider.of<FlocksStore>(context);
    return Provider.value(
      value: flocksStore.flocks.firstWhere((f) => '${f.id}' == flockId),
      child: FlockDetailFrame(
          flock: flocksStore.flocks.firstWhere((f) => '${f.id}' == flockId)),
    );
  }
}