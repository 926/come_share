import 'package:come_share/src/routes/collect/collect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:weebi/src/views/onboarding/onboarding.dart';
// import 'package:weebi/src/routes/cashcount/cashcount.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final collectorStore = Provider.of<CollectorStore>(context);
    //final thisCollector = collectorStore.shop.first;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.teal),
                      title: Text('home'),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(CollectRoute.routePath);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.motorcycle),
                      title: Text('Info magasin'),
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.of(context).pushNamed(
                        //     ColectorDetailRoute.generateRoute('0')); // for now
                      },
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.timeline,
                color: Colors.grey,
              ),
              title: Text('Stats du magasin'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(StatsSalesRoute.routePath);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.layers,
                color: Colors.orange[800],
              ),
              title: Text('Stats du stock'),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(StatsStockRoute.routePath);
              },
            ),
            // thisCollector.isLocked == true
            //     ? Container()
            //     :
            ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('Import .json'),
                onTap: () {
                  Navigator.of(context).pop();
                  //   Navigator.of(context)
                  //       .pushNamed(SettingsImportRoute.routePath);
                  // },
                  // ),
                  ListTile(
                    leading: Icon(Icons.save),
                    title: Text('Export .csv'),
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(ExportRoute.routePath);
                    },
                  ); //
                  /* ListTile(
              leading: Icon(Icons.important_devices),
              title: Text('Config test/prod'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(ShopLdbViewRoute.generateRoute('0'));
              },
            ), // */

                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('A propos'),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Navigator.of(context).pushNamed(AboutRoute.routePath);
                    },
                  ); //
                })
          ],
        ),
      ),
    );
  }
}
