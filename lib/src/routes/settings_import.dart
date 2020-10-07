import 'package:putu_putu/src/routes/app_route_base.dart';
import 'package:putu_putu/src/views/settings_import.dart';

class SettingsImportRoute extends AppRouteBase {
  static String routePath = '/settings_import';

  SettingsImportRoute()
      : super(
            child: SettingsImportView(),
            routePath: SettingsImportRoute.routePath);
}
