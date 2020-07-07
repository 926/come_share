import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/views/main_view/flocks/flock_detail_frame.dart';

class FlockDetailRoute extends RcRoute {
  static String routePath = '/tickets/:key';

  static String generateRoute(String key) =>
      RcRoute.generateRoute(routePath, pathParams: {'key': key});

  FlockDetailRoute() : super(path: FlockDetailRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<RcRouteParameters>(context);
    final flockKey = routeParams.pathParameters['key'];
    final flocksStore = Provider.of<FlocksStore>(context);
    return Provider.value(
      value: flocksStore.flocks.firstWhere((f) => '${f.key}' == flockKey),
      child: FlockDetailFrame(
          flock: flocksStore.flocks.firstWhere((f) => '${f.key}' == flockKey)),
    );
  }
}
