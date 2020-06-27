/* import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/routes/sync/sync.dart';
import 'package:come_share/src/routes/tickets/tickets.dart';
import 'package:come_share/src/routes/herders/herders.dart';
import 'package:come_share/src/routes/products/products.dart';
import 'package:come_share/src/routes/sell/sell.dart';
import 'package:come_share/src/routes/spend/spend.dart';
import 'package:come_share/src/stores/shop.dart';
import 'package:come_share/src/stores/cart.dart';
import 'package:come_share/src/utils/basic_dialog.dart';
import 'package:come_share/src/widgets/drawer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class MainView extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final GlobalKey<NavigatorState> mainNavigatorKey;
  final Widget floatingButton;
  final List<Widget> actions;

  MainView({
    @required this.body,
    @required this.selectedIndex,
    @required this.mainNavigatorKey,
    this.floatingButton,
    this.actions = const [],
  });

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<String> paths = [
    ProductsRoute.routePath,
    HerdersRoute.routePath,
    SellRoute.routePath,
    SpendRoute.routePath,
    TicketsRoute.routePath,
  ];

  List<Color> selectedColor = [
    Colors.orange[800],
    Colors.blue[800],
    Colors.teal,
    Colors.red[800],
    Colors.grey[400],
  ];
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Êtes vous sur ?'),
          content: Text('Vous allez quitter l\'application'),
          actions: <Widget>[
            FlatButton(
              child: Text('Rester'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            Spacer(),
            FlatButton(
              child: Text('Quitter'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget posIcon = Container(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          'assets/svg/pos.svg',
          fit: BoxFit.fitWidth,
          color: Colors.white,
        ));
    Widget posIconActive = Container(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          'assets/svg/pos.svg',
          fit: BoxFit.fitWidth,
          color: Colors.teal,
        ));

    final cartStore = Provider.of<CartStore>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor[widget.selectedIndex],
        title: InkWell(
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String appName = packageInfo.appName;
            String version = packageInfo.version;
            String buildNumber = packageInfo.buildNumber;
            showDialogCS(
                '$appName \nversion : $version buildNumber : $buildNumber',
                context);
          },
          child: Text(
            'CS',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: widget.actions,
      ),
      drawer: CSDrawer(),
      body: WillPopScope(onWillPop: _onBackPressed, child: widget.body),
      floatingActionButton: widget.floatingButton,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: selectedColor[widget.selectedIndex],
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF20272B),
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.selectedIndex,
        onTap: (newIndex) {
          if (shopStore.shop.first.isLocked == true &&
              paths[newIndex] == SpendRoute.routePath) {
            widget.mainNavigatorKey.currentState
                .pushReplacementNamed(SyncRoute.routePath);
          } else if (!shopStore.shop.first.isLocked &&
              cartStore.items.isNotEmpty &&
              widget.selectedIndex == 2 &&
              paths[newIndex] == SpendRoute.routePath) {
            showDialogCS(
                'Vider le panier vente avant de faire un achat', context);
          } else if (!shopStore.shop.first.isLocked &&
              cartStore.items.isNotEmpty &&
              widget.selectedIndex == 3 &&
              paths[newIndex] == SellRoute.routePath) {
            showDialogCS(
                'Vider le panier achat avant de faire une vente', context);
          } else if (paths[newIndex] != null) {
            widget.mainNavigatorKey.currentState
                .pushReplacementNamed(paths[newIndex]);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            title: Text('Produits'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: shopStore.shop.first.isLocked == true
                ? Text('Eleveurs')
                : Text('Contacts'),
          ),
          BottomNavigationBarItem(
            icon: posIcon,
            activeIcon: posIconActive,
            title: Text('Vente'),
          ),
          shopStore.shop.first.isLocked
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  title: Text('Sync'),
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Achat'),
                ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Tickets'),
          ),
        ],
      ),
    );
  }
}
 */
