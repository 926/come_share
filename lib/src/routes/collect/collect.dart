import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

class CollectRoute extends AppRouteBase {
  static String routePath = '/collect';

  CollectRoute(GlobalKey<NavigatorState> mainNavigatorKey)
      : super(
            child: Collect(
              mainNavigatorKey: mainNavigatorKey,
            ),
            routePath: CollectRoute.routePath);
}
