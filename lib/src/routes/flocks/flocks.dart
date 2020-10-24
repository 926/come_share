import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/main_view/flocks/flocks.dart';
import 'package:flutter/widgets.dart';

class FlocksRoute extends AppRouteBase {
  static String routePath = '/flocks';

  FlocksRoute(GlobalKey<NavigatorState> mainNavigator)
      : super(
            child: FlocksView(mainNavigator: mainNavigator),
            routePath: FlocksRoute.routePath);
}
