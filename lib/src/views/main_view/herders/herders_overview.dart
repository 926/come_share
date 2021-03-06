import 'package:flutter/material.dart';
import 'package:putu_putu/src/models/herder.dart';
import 'package:putu_putu/src/routes/herders/herder_detail.dart';

//import 'package:provider/provider.dart';
//import 'package:putu_putu/src/stores/collector.dart';

class HerdersOverview extends StatefulWidget {
  final Herder herder;

  HerdersOverview({@required this.herder});

  @override
  _HerdersOverviewState createState() => _HerdersOverviewState();
}

class _HerdersOverviewState extends State<HerdersOverview> {
  @override
  Widget build(BuildContext context) {
    // final shopStore = Provider.of<ShopStore>(context);
    // final thisShop = shopStore.shop.first;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
            HerderDetailRoute.generateRoute('${(widget.herder.id)}'));
      },
      child: ListTile(
          isThreeLine: true,
          leading: HerderAvatar(
            herder: widget.herder,
          ),
          title: Text('${widget.herder.firstName} ${widget.herder.lastName}',
              style: TextStyle(
                  decoration: widget.herder.status
                      ? null
                      : TextDecoration.lineThrough)),
          subtitle: Text('bidon : ${widget.herder.bidon}')),
    );
  }
}

class HerderAvatar extends StatelessWidget {
  final Herder herder;

  HerderAvatar({@required this.herder});

  @override
  Widget build(BuildContext context) {
    Widget image;
    // if (herder.avatar != null ) {
    //   //image = ClipOval(
    //   //child: Image.memory(herder.avatar),
    //   //);
    // } else {
    // }
    image = Text(
      '${herder.firstName.substring(0, 1).toUpperCase()}',
      style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
    );
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: image ?? Container(),
      ),
      width: 50,
      height: 50,
    );
  }
}
