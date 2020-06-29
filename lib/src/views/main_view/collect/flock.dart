import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/views/flocks/flock_detail.dart';

import 'collect.dart';

class FlockView extends StatefulWidget {
  @override
  _FlockViewState createState() => _FlockViewState();
}

class _FlockViewState extends State<FlockView> {
  @override
  Widget build(BuildContext context) {
    final niceFlock = Provider.of<FlockManager>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlockDetailWidget(
        flock: niceFlock.flock,
      ),
    );
  }
}
