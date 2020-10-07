import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/commodities/commodities.dart';

class CommoditiesRoute extends AppRouteBase {
  static String routePath = '/commodities';

  CommoditiesRoute()
      : super(child: CommoditiesView(), routePath: CommoditiesRoute.routePath);
}
