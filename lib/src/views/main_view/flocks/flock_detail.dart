import 'package:flutter/material.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:provider/provider.dart';
//import 'package:come_share/src/stores/collector.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/utils/formatters.dart';

class FlockDetailWidget extends StatefulWidget {
  final Flock flock;

  FlockDetailWidget({@required this.flock});

  @override
  _FlockDetailWidgetState createState() => _FlockDetailWidgetState();
}

class _FlockDetailWidgetState extends State<FlockDetailWidget> {
  bool flockStatus;

  @override
  void initState() {
    super.initState();
    flockStatus = widget.flock.status;
  }

  @override
  Widget build(BuildContext context) {
    //final shopStore = Provider.of<ShopStore>(context, listen: false);
    final herdersStore = Provider.of<HerdersStore>(context, listen: false);
    final herders = herdersStore.herders;
    Herder thisHerder;

    if (herders.isNotEmpty) {
      thisHerder = herdersStore?.herders?.firstWhere(
          (h) => h.id.toString() == widget?.flock?.herderId,
          orElse: () => herders.first);
    } else {
      thisHerder = null;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.receipt,
                ),
                SizedBox(
                  width: 28,
                ),
                Text('${widget.flock.id}'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.schedule,
                ),
                SizedBox(
                  width: 28,
                ),
                Text(widget.flock.date.toString())
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 28,
                ),
                Text('${widget.flock.type}'),
              ],
            ),
            Divider(),
            for (final item in widget.flock.items)
              Row(
                children: <Widget>[
                  Text('quantite : '),
                  Expanded(
                    child: Text('${item.quantity}'),
                  ),
                ],
              ),
            Divider(),
            widget.flock.comment != null && widget.flock.comment != ''
                ? Row(
                    children: <Widget>[
                      Icon(Icons.assignment),
                      SizedBox(
                        width: 28,
                      ),
                      Expanded(
                        child: Text('${widget.flock.comment}'),
                      ),
                    ],
                  )
                : Container(),
            if (widget.flock.status == false)
              Row(
                children: <Widget>[
                  Icon(Icons.delete),
                  SizedBox(
                    width: 28,
                  ),
                  Expanded(child: Text("Collecte desactivee le : ")),
                  Text(widget.flock.statusUpdateDate.toString()),
                ],
              ),
            if (widget.flock?.herderId == '0' || widget.flock?.herderId == null)
              Container()
            else
              Row(
                children: <Widget>[
                  Icon(Icons.speaker_phone),
                  SizedBox(
                    width: 28,
                  ),
                  Text(thisHerder != null ? 'num : ${thisHerder.bidon}' : ''),
                ],
              ),
            Row(
              children: <Widget>[
                Icon(Icons.portrait),
                SizedBox(
                  width: 28,
                ),
                Text(thisHerder != null
                    ? '${thisHerder?.firstName} ${thisHerder?.lastName}'
                    : ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
