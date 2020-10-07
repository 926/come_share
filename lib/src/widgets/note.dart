import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:putu_putu/src/stores/cart.dart';
import 'package:putu_putu/src/utils/formatters.dart';
//import 'package:putu_putu/src/stores/commodities.dart';
//import 'package:putu_putu/src/stores/collectors.dart';

class NoteView extends StatefulWidget {
  final Future<void> Function() onOk;

  NoteView({@required this.onOk});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isCvo;
  double cvoTotal;
  bool displayCvo;

  // promo == cvo, different from discount !
  bool isDiscounted;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final collectorStore = Provider.of<CollectorStore>(context);
    //final thisCollector = collectorStore.collector.first;
    final cartStore = Provider.of<CartStore>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () => widget.onOk(),
          child: Icon(Icons.arrow_forward)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text('Total'),
                    ),
                    Observer(
                      builder: (context) => Text(
                        numberFormatter.format(cartStore.qt),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.title,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                ListTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentField extends StatefulWidget {
  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  TextEditingController _comment;

// consider putting a tickbox
//  bool _isCommented = false;
//  _isSearching ? _buildSearchField() : _buildTitle(context),

  @override
  void initState() {
    super.initState();
    _comment = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Commentaire',
        icon: Icon(Icons.assignment),
      ),
      controller: _comment,
      onSubmitted: (value) {
        cartStore.setComment(value);
      },
    );
  }
}
