import 'package:putu_putu/src/models/collector.dart';
import 'package:putu_putu/src/routes/collect/collect.dart';
import 'package:putu_putu/src/routes/collector_detail.dart';
import 'package:putu_putu/src/routes/commodities/commodities.dart';
import 'package:putu_putu/src/routes/export.dart';
import 'package:putu_putu/src/routes/settings_import.dart';
import 'package:putu_putu/src/stores/collector.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectorStore = Provider.of<CollectorStore>(context);
    final thisCollector = collectorStore.collector ?? Collector();

    return Drawer(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      thisCollector.companyPhoto == null ||
                              thisCollector.companyPhoto.isEmpty
                          ? Container()
                          : Container(
                              height: 80,
                              child: Image(
                                image: AssetImage(
                                    'assets/photos/${thisCollector.companyPhoto}'),
                              ),
                            ),
                      ListTile(
                        /* leading: SvgPicture.asset(
                          'assets/svg/calculator.svg',
                          color: Colors.teal,
                        ), */
                        title: Text('putu-putu'),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(CollectRoute.routePath);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.motorcycle, color: Colors.red[400]),
                title: Text('Info collecteur'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamed(CollectorRoute.routePath); // for now
                },
              ),
              ListTile(
                leading: Icon(Icons.widgets),
                title: Text('Commodités'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    CommoditiesRoute.routePath,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('Import .json'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamed(SettingsImportRoute.routePath);
                },
              ),
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Export .csv / .xlsl'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ExportRoute.routePath);
                },
              ), //
            ],
          ),
        ),
      ),
    );
  }
}

//ListTile(
//  leading: Icon(Icons.help_outline),
//  title: Text('A propos'),
//  onTap: () {
//    Navigator.of(context).pop();
//    // Navigator.of(context).pushNamed(AboutRoute.routePath);
//  },
//),
/* ListTile(
              leading: Icon(Icons.important_devices),
              title: Text('Config test/prod'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(ShopLdbViewRoute.generateRoute('0'));
              },
            ), */
/* ListTile(
              leading: Icon(
                Icons.layers,
                color: Colors.orange[800],
              ),
              title: Text('Stats'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(StatsStockRoute.routePath);
              },
            ), */
