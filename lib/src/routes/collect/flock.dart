import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_router/rc_router.dart';
import 'package:putu_putu/src/models/flock.dart';
import 'package:putu_putu/src/views/main_view/collect/flock.dart';

class CollectFlockRoute extends RcRoute {
  static String routePath = '/sellticket';

  CollectFlockRoute() : super(path: CollectFlockRoute.routePath);

  Widget build(BuildContext context) => FlockView();

  @override
  Route routeBuilder(RouteSettings routeSettings) {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (c, _, __) {
        return Provider<Flock>.value(
          value: routeSettings.arguments,
          child: handle(context: c, routeSettings: routeSettings),
        );
      },
      settings: routeSettings,
    );
  }
}
