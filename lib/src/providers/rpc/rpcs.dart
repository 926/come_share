import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/providers/rpc/flock.dart';
import 'package:come_share/src/providers/rpc/herder.dart';
import 'package:come_share/src/providers/rpc/commodity.dart';

class RpcsProvider extends StatelessWidget {
  final Widget child;

  RpcsProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...herderRpc,
        ...flockRpc,
        ...commodityRpc,
      ],
      child: child,
    );
  }
}
