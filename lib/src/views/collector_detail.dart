import 'package:come_share/src/stores/collector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final collectorStore = Provider.of<CollectorStore>(context);
    final thisCollector = collectorStore.collector.first;
    return Scaffold(
      appBar: AppBar(
        title: Text('Collecteur'),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.face, // get filter number
                    ),
                  ],
                ),
              ),
              Text(
                "Nom ",
              ),
              Text(
                "${thisCollector.firstName} ${thisCollector.lastName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.phone, // get filter number
                    ),
                  ],
                ),
              ),
              Text(
                "Numéro de téléphone : ",
              ),
              Text(
                "${thisCollector.tel}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.alternate_email, // get filter number
                    ),
                  ],
                ),
              ),
              Text(
                "Mail : ",
              ),
              Text(
                "${thisCollector.mail}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.location_city, // get filter number
                    ),
                  ],
                ),
              ),
              Text(
                "Adresse : ",
              ),
              Text(
                "${thisCollector.address}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
