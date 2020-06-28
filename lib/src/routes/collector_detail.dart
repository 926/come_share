import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/collector_detail.dart';

class CollectorRoute extends AppRouteBase {
  static String routePath = '/collector';

  CollectorRoute()
      : super(
            child: CollectorDetailView(), routePath: CollectorRoute.routePath);
}
