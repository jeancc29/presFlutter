import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool selected;
  MyListTile({Key key, @required this.title, @required this.icon, this.selected = false}) : super(key: key);
  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        color: widget.selected ? Colors.blue[50] : Colors.transparent,
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
      ),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          dense: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Icon(widget.icon, color: widget.selected ? Utils.colorPrimaryBlue : Colors.grey.shade700,),
          ),
          title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13.3, color: widget.selected ? Utils.colorPrimaryBlue : Colors.grey.shade700)),
        )
    );
  }
}