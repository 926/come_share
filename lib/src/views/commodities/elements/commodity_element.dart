import 'package:flutter/material.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/routes/commodities/commodity_detail.dart';
import 'package:come_share/src/utils/formatters.dart';
import 'package:come_share/src/views/commodities/elements/lot_element.dart';

class CommodityItemWidget extends StatefulWidget {
  final Commodity commodity;

  CommodityItemWidget({@required this.commodity});

  @override
  _CommodityItemWidgetState createState() => _CommodityItemWidgetState();
}

class _CommodityItemWidgetState extends State<CommodityItemWidget> {
  Color iconColor;
  @override
  void initState() {
    super.initState();
    iconColor = Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Navigator.of(context).pushNamed(
            CommodityDetailRoute.generateRoute('${widget.commodity.id}'));
      },
      child: ExpansionTile(
        onExpansionChanged: (bool expanding) => setState(
          () => iconColor = expanding ? Color(0xFF0097A7) : Colors.grey,
        ),
        title: Row(
          children: <Widget>[
            Text('${widget.commodity.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.commodity.weight == 1
                      ? '${widget.commodity.name}'
                      : '${widget.commodity.name} (x${widget.commodity.weight})',
                  style: TextStyle(
                      decoration: widget.commodity.status
                          ? null
                          : TextDecoration.lineThrough),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.commodity.id != 0
                    ? '${numberFormatter?.format(widget.commodity.lots.fold(0, (lotValue, lot) => lotValue + (lot?.quantity)))}'
                    : ''),
                Icon(Icons.opacity, color: iconColor)
              ],
            ),
            //SizedBox(width: ScreenUtil().setWidth(10)),
          ],
        ),
        children: <Widget>[
          for (final lot in widget.commodity.lots)
            LotItemWidget(
              commodity: widget.commodity,
              lot: lot,
            )
        ],
      ),
    );
  }
}
