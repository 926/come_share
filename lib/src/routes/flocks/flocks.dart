import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/flocks/flocks.dart';

class FlocksRoute extends AppRouteBase {
  static String routePath = '/tickets';

  FlocksRoute() : super(child: FlocksView(), routePath: FlocksRoute.routePath);
}
