import 'package:flutter/widgets.dart';
import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/collect/herder_scan.dart';

class CollectHerderRoute extends AppRouteBase {
  static String routePath = '/herderCollect';
  //final Future<void> Function(Flock flock) onSubmit;

  CollectHerderRoute({GlobalKey<NavigatorState> mainNavigatorKey
      //this.onSubmit
      })
      : super(
            child: HerderCollectView(
              mainNavigatorKey: mainNavigatorKey,
              //onSubmit: onSubmit,
            ),
            routePath: CollectHerderRoute.routePath);
}
