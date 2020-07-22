import 'package:come_share/src/stores/flocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/models/lot.dart';
import 'package:come_share/src/routes/commodities/lot_detail.dart';
import 'package:come_share/src/utils/formatters.dart';
import 'package:provider/provider.dart';

class LotItemWidget extends StatelessWidget {
  final Commodity commodity;
  final Lot lot;

  LotItemWidget({@required this.commodity, this.lot});

  @override
  Widget build(BuildContext context) {
    final flocksStore = Provider.of<FlocksStore>(context);
    final _lotQtIn = flocksStore.lotQuantityIn(lot);

    return InkWell(
      onLongPress: () {
        Navigator.of(context).pushNamed(
            LotDetailRoute.generateRoute('${lot.commodityId}', '${lot.id}'));
      },
      child: ListTile(
        leading: SizedBox(
            width: 75,
            //height: 50,
            child: Text(lot.id == 1 ? 'lot' : '${lot.commodityId}.${lot.id}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey))),
        title: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('${numberFormatter?.format(_lotQtIn ?? 0.0)}',
                    style: TextStyle(color: Colors.grey)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: ScreenUtil().setWidth(10)),
                Icon(Icons.opacity, color: Colors.grey),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.free_breakfast, color: Colors.transparent),
      ),
    );
  }
}
