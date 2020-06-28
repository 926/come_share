import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/commodities/commodities.dart';

class CommoditiesRoute extends AppRouteBase {
  static String routePath = '/commodities';

  CommoditiesRoute(GlobalKey<NavigatorState> mainNavigator)
      : super(
            child: CommoditiesView(
              mainNavigator: mainNavigator,
            ),
            routePath: CommoditiesRoute.routePath);
}
