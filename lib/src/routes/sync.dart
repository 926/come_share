import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/main_view/sync.dart';
import 'package:flutter/widgets.dart';

class SyncRoute extends AppRouteBase {
  static String routePath = '/sync';

  SyncRoute(GlobalKey<NavigatorState> mainNavigator)
      : super(
            child: SyncView(mainNavigator: mainNavigator),
            routePath: SyncRoute.routePath);
}
