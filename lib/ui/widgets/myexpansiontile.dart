import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';

class MyExpansionTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<MyListTile> listaMylisttile;
  MyExpansionTile({Key key, @required this.title, @required this.icon, @required this.listaMylisttile}) : super(key: key);
  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ExpansionTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Icon(Icons.file_download,),
        ),
        title: Text(widget.title, style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.w600 )),
        children: widget.listaMylisttile,
      ),
    );
  }
}