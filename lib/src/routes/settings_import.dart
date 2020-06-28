import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/settings_import.dart';

class SettingsImportRoute extends AppRouteBase {
  static String routePath = '/settings_import';

  SettingsImportRoute()
      : super(child: SettingsImportView(), routePath: SettingsImportRoute.routePath);
}
