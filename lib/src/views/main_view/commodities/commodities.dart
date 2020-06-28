//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:come_share/src/models/commodity.dart';
import 'package:come_share/src/stores/commodities.dart';
//import 'package:come_share/src/stores/collector.dart';
import 'package:come_share/src/views/main_view/main_view.dart';
import 'package:come_share/src/views/main_view/commodities/items/product_item.dart';

class CommoditiesView extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigator;

  CommoditiesView({@required this.mainNavigator});

  @override
  _CommoditiesViewState createState() => _CommoditiesViewState();
}

class _CommoditiesViewState extends State<CommoditiesView> {
  String scanBarcode;
  TextEditingController barcodeController;

  List<Commodity> productsListReordered;
  bool isListReorderedByProductTitle;
  bool isListReorderedById;
  bool isTitleAscending;
  bool isIdAscending;

  List<Commodity> searchResults;
  bool isSearch;
  bool isSearchByBarcode;
  Icon actionIcon = new Icon(Icons.search, color: Colors.orange[800]);
  // Widget appBarTitle = new Text("List of p");

  bool submitting = false;

  @override
  void initState() {
    super.initState();
    scanBarcode = '';
    isSearch = false;
    isSearchByBarcode = false;
    isListReorderedByProductTitle = false;
    isListReorderedById = false;
    isTitleAscending = true;
    isIdAscending = true;

    barcodeController?.addListener(() {
      final text = barcodeController.text.toLowerCase();
      barcodeController.value = barcodeController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    if (barcodeController != null) {
      barcodeController.clear();
      barcodeController.dispose();
    }
  }

  void _searchByTitleOrCode(String queryString) {
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    var temp = commoditiesStore.commodities.where((p) {
      return p.name.toLowerCase().contains(queryString.toLowerCase());
    }).toList();
    setState(() {
      searchResults = temp;
    });
  }

  void _orderByTitle(bool _isAscending) {
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    List<Commodity> ordering = commoditiesStore.commodities;
    if (_isAscending == true) {
      ordering.sort((a, b) => a.name.compareTo(b.name));
    } else {
      ordering.sort((a, b) => b.name.compareTo(a.name));
    }
    setState(() {
      isTitleAscending = !_isAscending;
      productsListReordered = ordering;
      isListReorderedByProductTitle = true;
      isListReorderedById = false;
      isSearch = false;
    });
  }

  void _orderById(bool _isAscending) {
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    List<Commodity> ordering = commoditiesStore.commodities;
    if (_isAscending == true) {
      ordering.sort((a, b) => a.id.compareTo(b.id));
    } else {
      ordering.sort((a, b) => b.id.compareTo(a.id));
    }
    setState(() {
      isIdAscending = !_isAscending;
      productsListReordered = ordering;
      isListReorderedById = true;
      isListReorderedByProductTitle = false;
      isSearch = false;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  List<Commodity> preserveOldAndRemoveDuplicates(
      List<Commodity> _oldList, List<Commodity> _newList) {
    Map<String, Commodity> mapOldList = {};
    for (var p in _oldList) {
      mapOldList[p.name] = p;
    }
    Map<String, Commodity> mapNewList = {};
    for (var p in _newList) {
      mapNewList[p.name] = p;
    }
    for (var commodity in _newList) {
      if (mapOldList.keys.contains(commodity.name)) {
        mapNewList.remove(commodity.name);
      }
    }
    return _oldList.followedBy(mapNewList.values.toList()).toList();
    // on peut même + tard identifier les éléments nouveaux et les doublons
    // mapNewList.values.toList().length
  }

  @override
  Widget build(BuildContext context) {
    final commoditiesStore = Provider.of<CommoditiesStore>(context);
    var coolComm =
        commoditiesStore.commodities.where((h) => h.id != 0).toList();
    // final collectorStore = Provider.of<CollectorStore>(context);
    // var thisCollector = collectorStore.collector.first;

    return MainView(
      selectedIndex: 0,
      actions: <Widget>[
        IconButton(
          icon: isIdAscending == true
              ? Icon(Icons.keyboard_arrow_up)
              : Icon(Icons.keyboard_arrow_down),
          onPressed: () {
            _orderById(isIdAscending);
          },
        ),
        IconButton(
          icon: isTitleAscending == true
              ? Icon(Icons.sort_by_alpha)
              : Icon(Icons.sort_by_alpha),
          onPressed: () {
            _orderByTitle(isTitleAscending);
          },
        ),
      ],
      mainNavigatorKey: widget.mainNavigator,
      body: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                if (isSearchByBarcode && searchResults != null ||
                    isSearch && searchResults != null)
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildSearchBody(context, index),
                      ),
                    ),
                  )
                else if (isListReorderedByProductTitle == true ||
                    isListReorderedById ==
                        true) // handle null, default case as well in view)
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: productsListReordered.length,
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
                        itemCount: coolComm.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildBody(context, index, coolComm),
                      ),
                    ),
                  ),
                // below empty widget at bottom so that last product can also be selected
                ListTile(
                  title: Text(''),
                ),
                !isSearch
                    ? Container()
                    : Row(
                        children: <Widget>[
                          Flexible(
                            flex: 6,
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: TextField(
                                autofocus: true,
                                onChanged: (value) {
                                  _searchByTitleOrCode(value);
                                },
                                style: TextStyle(color: Colors.blue),
                                keyboardType: TextInputType.text,
                                //onTap: () => setState(() => isSearchByBarcode = true),
                                decoration: InputDecoration(
                                  hintText: "nom / code",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
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
          );
        }),
      ),
      floatingButton: FloatingActionButton(
        heroTag: "btnSearchProducts",
        backgroundColor: Color(0xFF20272B),
        //mini: true,
        child:
            //isSearchByBarcode == false
            actionIcon,
        onPressed: () {
          setState(() {
            // bool not used anymore in UI but could always be needed
            if (this.actionIcon.icon == Icons.search) {
              isSearch = true;
              this.actionIcon = new Icon(Icons.close);
            } else {
              isSearch = false;
              this.actionIcon = new Icon(Icons.search);
            }
          });
        },
      ),
    );
  }

  Widget buildBody(
      BuildContext context, int index, List<Commodity> listCommoditiesStore) {
    return CommodityItemWidget(commodity: listCommoditiesStore[index]);
  }

  Widget buildSearchBody(BuildContext context, int index) {
    // return ProductItemWidget(product: searchResults[index]);
    return CommodityItemWidget(commodity: searchResults[index]);
  }

  Widget buildReorderedList(BuildContext context, int index) {
    return CommodityItemWidget(commodity: productsListReordered[index]);
  }
}
