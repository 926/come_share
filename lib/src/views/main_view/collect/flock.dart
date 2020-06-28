import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/views/main_view/flocks/flock_detail.dart';

class FlockView extends StatefulWidget {
  @override
  _FlockViewState createState() => _FlockViewState();
}

class _FlockViewState extends State<FlockView> {
  @override
  Widget build(BuildContext context) {
    final niceFlock = Provider.of<Flock>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlockDetailWidget(
        flock: niceFlock,
      ),
    );
  }
}
