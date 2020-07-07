import 'package:come_share/src/views/main_view/main_view.dart';
import 'package:come_share/src/widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/stores/flocks.dart';
import 'package:come_share/src/views/main_view/flocks/flock_overview.dart';

class FlocksView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigator;

  FlocksView({@required this.mainNavigator});

  @override
  _FlocksViewState createState() => _FlocksViewState();
}

class _FlocksViewState extends State<FlocksView> {
  bool _activeSearch;
  List<Flock> _searchResults;

  @override
  void initState() {
    super.initState();
    _activeSearch = false;
  }

  void _search(String queryString) {
    final flocksStore = Provider.of<FlocksStore>(context);
    List<Flock> searching = flocksStore.searchFlockById(queryString);
    setState(() {
      _searchResults = searching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flocksStore = Provider.of<FlocksStore>(context, listen: true);
    /* final shopStore = Provider.of<ShopStore>(context);
    final thisShop = shopStore.shop.first; */

    return MainView(
      selectedIndex: 2,
      mainNavigatorKey: widget.mainNavigator,
      body: Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            _activeSearch
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        child: Icon(Icons.search, color: Colors.white),
                        heroTag: 'bt1',
                        backgroundColor: Colors.blueGrey,
                        onPressed: () {
                          setState(() {
                            _activeSearch = true;
                          });
                        },
                      ),
                    ),
                  ),
          ],
        ),
        body: Column(
          children: <Widget>[
            if (_activeSearch == false) // breakpoint for some reason
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: flocksStore.flocks.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildBody(context, index),
                  ),
                ),
              )
            else if (_searchResults == null) // handle null, default case
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: flocksStore.flocks.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildBody(context, index),
                  ),
                ),
              )
            else
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildSearchBody(context, index),
                  ),
                ),
              ),
            _activeSearch ? _searchList() : Container()
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, int index) {
    final flocksStore = Provider.of<FlocksStore>(context, listen: true);
    var reversedflocksStore = flocksStore.flocks.reversed.toList();
    return FlockOverviewWidget(flock: reversedflocksStore[index]);
  }

  Widget buildSearchBody(BuildContext context, int index) {
    return FlockOverviewWidget(flock: _searchResults[index]);
  }

  ListTile _searchList() {
    return ListTile(
        leading: Icon(
            Icons.search), //to remove icon : automaticallyImplyLeading: false
        title: TextField(
          onChanged: _search,
          style: TextStyle(color: Colors.grey[800]),
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Numéro de reçu",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => setState(() => _activeSearch = false),
        ));
  }
}
