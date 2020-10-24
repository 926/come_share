import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/export.dart';

class ExportRoute extends AppRouteBase {
  static String routePath = '/export';

  ExportRoute() : super(child: Export(), routePath: ExportRoute.routePath);
}
