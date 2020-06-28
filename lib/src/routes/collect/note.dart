import 'package:come_share/src/routes/app_route_base.dart';
import 'package:come_share/src/views/main_view/collect/note.dart';

class NoteRoute extends AppRouteBase {
  static String routePath = '/note';
  final Future<void> Function() onOkOk;

  NoteRoute({this.onOkOk})
      : super(
            child: NoteView(
              onOk: onOkOk,
            ),
            routePath: NoteRoute.routePath);
}