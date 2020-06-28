import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/export.dart';

class ExportRoute extends AppRouteBase {
  static String routePath = '/export';

  ExportRoute()
      : super(child: Export(), routePath: ExportRoute.routePath);
}
