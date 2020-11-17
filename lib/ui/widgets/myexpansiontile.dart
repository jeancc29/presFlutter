import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';

class MyExpansionTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<MyListTile> listaMylisttile;
  final bool initialExpanded;
  MyExpansionTile({Key key, @required this.title, @required this.icon, @required this.listaMylisttile, this.initialExpanded = false}) : super(key: key);
  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ExpansionTile(
        initiallyExpanded: widget.initialExpanded,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Icon(widget.icon,),
        ),
        title: Text(widget.title, style: TextStyle(fontFamily: "GoogleSans", fontSize: 14.3, fontWeight: FontWeight.w500 )),
        children: widget.listaMylisttile,
      ),
    );
  }
}