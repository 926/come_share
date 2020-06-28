import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/collect/herder.dart';

class CollectHerderRoute extends AppRouteBase {
  static String routePath = '/client';
  final Future<void> Function() onOkOk;

  CollectHerderRoute({GlobalKey<NavigatorState> mainNavigatorKey, this.onOkOk})
      : super(
            child: HerderView(
              mainNavigatorKey: mainNavigatorKey,
              onOk: onOkOk,
            ),
            routePath: CollectHerderRoute.routePath);
}
