import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/collect/collect.dart';

class CollectRoute extends AppRouteBase {
  static String routePath = '/collect';

  CollectRoute(GlobalKey<NavigatorState> mainNavigator)
      : super(
            child: Collect(
              mainNavigator: mainNavigator,
            ),
            routePath: CollectRoute.routePath);
}
