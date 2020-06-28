import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/routes/collector_detail.dart';

class CollectorDetailView extends StatefulWidget {
  CollectorDetailView();

  @override
  _CollectorDetailViewState createState() => _CollectorDetailViewState();
}

class _CollectorDetailViewState extends State<CollectorDetailView> {
  bool isApproved = false;
  BuildContext myContext;
  bool submitting = false;
  var token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Collecteur'),
        ),
        body: Center(child: Text('work in progress')));
  }
}
