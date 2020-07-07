import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/commodities/commodities.dart';

class CommoditiesRoute extends AppRouteBase {
  static String routePath = '/commodities';

  CommoditiesRoute()
      : super(child: CommoditiesView(), routePath: CommoditiesRoute.routePath);
}
