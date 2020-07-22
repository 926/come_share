import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/main_view/flocks/flock_detail.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'collect.dart';

class FlockView extends StatefulWidget {
  @override
  _FlockViewState createState() => _FlockViewState();
}

class _FlockViewState extends State<FlockView> {
  String animationName;
  @override
  void initState() {
    super.initState();
    animationName = 'init';
  }

  void animFirst() => setState(() => animationName = 'first');
  void animMiddle() => setState(() => animationName = 'middle');
  void animLast() => setState(() => animationName = 'last');

  @override
  Widget build(BuildContext context) {
    animFirst();
    animMiddle();
    animLast();
    final niceFlock = Provider.of<FlockManager>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlockDetailWidget(
            flock: niceFlock.flock,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: 150,
            color: Colors.grey[300],
            child: FlareActor("assets/rive/cow.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: animationName),
          ),
        ),
      ],
    );
  }
}
