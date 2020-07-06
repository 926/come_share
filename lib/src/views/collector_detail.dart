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
    //print(thisCollector.name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Collecteur'),
        backgroundColor: Colors.red[400],
      ),
      body: Stack(
        children: [
          thisCollector.collectorPhoto == null ||
                  thisCollector.collectorPhoto.isEmpty
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.blue[900],
                    child: Image(
                      width: MediaQuery.of(context).size.height * 0.60,
                      image: AssetImage(
                          'assets/photos/${thisCollector.collectorPhoto}'),
                    ),
                  ),
                ),
          Column(
            children: [
              Container(height: 20),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.motorcycle, // get filter number
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Nom : ",
                  ),
                  Expanded(
                    child: Text(
                      "${thisCollector.firstName} ${thisCollector.lastName}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff053661)),
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
                  Expanded(
                    child: Text(
                      "${thisCollector.tel}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff053661)),
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
                  Expanded(
                    child: Text(
                      "${thisCollector.mail}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff053661)),
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
                  Expanded(
                    child: Text(
                      "${thisCollector.address}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff053661)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
