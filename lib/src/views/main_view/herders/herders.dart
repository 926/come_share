import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/stores/herders.dart';
import 'package:come_share/src/views/main_view/herders/herders_overview.dart';
import 'package:come_share/src/views/main_view/main_view.dart';
//import 'package:come_share/src/stores/collector.dart';

class HerdersView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigator;
  final Herder herder;

  HerdersView({@required this.mainNavigator, this.herder});

  @override
  _HerdersViewState createState() => _HerdersViewState();
}

class _HerdersViewState extends State<HerdersView> {
  List<Herder> herdersListReordered;
  List<Herder> _searchResults;
  bool _isSearch;
  Icon actionIcon = Icon(Icons.search, color: Colors.blue);

  bool _isListReorderedByFirstName;
  bool _isListReorderedByBidon;
  bool _isBidonAscending;
  bool _isFirstNameAscending;
  TextEditingController dowap;

  bool submitting = false;

  @override
  void initState() {
    dowap = TextEditingController(text: '');
    super.initState();
    _isSearch = false;
    _isListReorderedByFirstName = false;
    _isListReorderedByBidon = false;
    _isBidonAscending = true;
    _isFirstNameAscending = true;
  }

  void _search(String queryString) {
    final herdersStore = Provider.of<HerdersStore>(context);
    //List<Herder> searching = herdersStore.searchHerdersByBidon(queryString);
    var temp = herdersStore.herders.where((h) {
      return h.bidon.toString().contains(queryString) ||
          h.firstName.toLowerCase().contains(queryString.toLowerCase()) ||
          h.lastName.toLowerCase().contains(queryString.toLowerCase());
    }).toList();
    setState(() {
      _searchResults = temp;
    });
  }

  /* void _searchById(String queryString) {
    final herdersStore = Provider.of<HerdersStore>(context);
    //List<Herder> searching = herdersStore.searchHerdersByBidon(queryString);
    var temp = herdersStore.herders.where((h) {
      return h.id.toString().contains(queryString);
    }).toList();
    setState(() {
      _searchResults = temp;
    });
  } */

  void _orderByFirstName(bool _isAscending) {
    final herdersStore = Provider.of<HerdersStore>(context);
    List<Herder> ordering = herdersStore.herders;
    if (_isAscending == true) {
      ordering.sort((a, b) => a.firstName.compareTo(b.firstName));
    } else {
      ordering.sort((a, b) => b.firstName.compareTo(a.firstName));
    }
    setState(() {
      _isFirstNameAscending = !_isAscending;
      herdersListReordered = ordering;
      _isListReorderedByFirstName = true;
      _isListReorderedByBidon = false;
    });
  }

  void _orderByBidon(bool _isAscending) {
    final herdersStore = Provider.of<HerdersStore>(context);
    List<Herder> ordering = herdersStore.herders;
    if (_isAscending == true) {
      ordering.sort((a, b) => a.bidon.compareTo(b.bidon));
    } else {
      ordering.sort((a, b) => b.bidon.compareTo(a.bidon));
    }
    setState(() {
      _isBidonAscending = !_isAscending;
      herdersListReordered = ordering;
      _isListReorderedByBidon = true;
      _isListReorderedByFirstName = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final herdersStore = Provider.of<HerdersStore>(context);
    var herdersSkip = herdersStore.herders.where((h) => h.id != 0).toList();
//    final shopStore = Provider.of<ShopStore>(context);
//    var thisShop = shopStore.shop.first;

    return MainView(
        mainNavigatorKey: widget.mainNavigator,
        selectedIndex: 0,
        actions: <Widget>[
          IconButton(
            icon: _isBidonAscending == true
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              _orderByBidon(_isBidonAscending);
            },
          ),
          IconButton(
            icon: _isFirstNameAscending == true
                ? Icon(Icons.sort_by_alpha)
                : Icon(Icons.sort_by_alpha),
            onPressed: () {
              _orderByFirstName(_isFirstNameAscending);
            },
          ),
        ],
        body: Column(
          children: <Widget>[
            if (_isSearch && _searchResults != null)
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildSearchBody(context, index),
                  ),
                ),
              )
            else if (_isListReorderedByFirstName == true ||
                _isListReorderedByBidon ==
                    true) // handle null, default case as well in view)
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: herdersListReordered.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildReorderedList(context, index),
                  ),
                ),
              )
            else
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: herdersSkip.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildBody(context, index, herdersSkip),
                  ),
                ),
              ),
            !_isSearch
                ? Container()
                : Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: ListTile(
                          leading: Icon(Icons.search),
                          title: TextField(
                            autofocus: false,
                            onChanged: (value) {
                              _search(value);
                            },
                            style: TextStyle(color: Colors.blue),
                            keyboardType: TextInputType.number,
                            onTap: () => setState(() {
                              _isSearch = true;
                            }),
                            decoration: InputDecoration(
                              hintText: "bidon/nom/prénom",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            controller: dowap,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _isSearch = false;
                                dowap.text = '';
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
          ],
        ),
        floatingButton: Stack(
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btnSearchHerders",
              backgroundColor: Color(0xFF20272B),
              //mini: true,
              child:
                  //isSearchByBarcode == false
                  actionIcon,
              onPressed: () {
                setState(() {
                  // bool not used anymore in UI but could always be needed
                  if (this.actionIcon.icon == Icons.search) {
                    _isSearch = true;
                    this.actionIcon = Icon(Icons.close);
                  } else {
                    _isSearch = false;
                    this.actionIcon = Icon(Icons.search, color: Colors.blue);
                  }
                });
              },
            ),
          ],
        ));
  }

  Widget buildBody(
      BuildContext context, int index, List<Herder> listHerdersStore) {
    return HerderOverview(herder: listHerdersStore[index]);
  }

  Widget buildSearchBody(BuildContext context, int index) {
    return HerderOverview(herder: _searchResults[index]);
  }

  Widget buildReorderedList(BuildContext context, int index) {
    return HerderOverview(herder: herdersListReordered[index]);
  }
}
