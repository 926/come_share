import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/herders/herders.dart';

class HerdersRoute extends AppRouteBase {
  static String routePath = '/herders';

  HerdersRoute(GlobalKey<NavigatorState> mainNavigator)
      : super(
            child: HerdersView(
              mainNavigator: mainNavigator,
            ),
            routePath: HerdersRoute.routePath);
}
