import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart' as sembast;

class DatabaseProvider extends StatelessWidget {
  final sembast.Database database;
  final Widget child;

  DatabaseProvider({@required this.child, @required this.database});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: database,
      child: child,
    );
  }
}
