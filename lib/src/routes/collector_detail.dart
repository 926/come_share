import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/collector_detail.dart';

class CollectorRoute extends AppRouteBase {
  static String routePath = '/collector';

  CollectorRoute()
      : super(
            child: CollectorDetailView(), routePath: CollectorRoute.routePath);
}
