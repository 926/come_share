import 'package:come_share/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/routes/flocks/flock_detail_frame.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:provider/provider.dart';
//import 'package:come_share/src/stores/collector.dart';

class FlockOverviewWidget extends StatelessWidget {
  final Flock flock;

  FlockOverviewWidget({@required this.flock});

  @override
  Widget build(BuildContext context) {
    //final collectorStore = Provider.of<CollectorStore>(context, listen: false);
    //final thisCollector = collectorStore.collector.first;

    final herdersStore = Provider.of<HerdersStore>(context, listen: false);
    Herder thisHerder = herdersStore.herders.firstWhere(
        (h) => h.id.toString() == flock.herderId,
        orElse: () => herdersStore.herders.first);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(FlockDetailRoute.generateRoute('${flock.key}'));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('#${flock.key}'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 8,
                  ),
                ),
                Text(flock.status == true ? '' : 'annulé',
                    style: TextStyle(
                        fontStyle: FontStyle
                            .italic)), // to update accordingly with // if ticket is disabled icon displayed in grey
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    flock.status == true
                        ? '${flock.type} : ${numberFormatter.format(flock.items.fold(0, (prev, element) => prev + element.quantity))}'
                        : '${flock.status}',
                  ),
                  Text(
                      '${thisHerder.firstName} ${thisHerder.lastName} n°${thisHerder.bidon}'),
                  Text(
                    '${flock.date.year}_${flock.date.month}_${flock.date.day} a ${flock.date.hour}:${flock.date.minute}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
