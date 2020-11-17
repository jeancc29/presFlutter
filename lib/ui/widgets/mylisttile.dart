import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final bool cargando;
  final IconData icon;
  final bool selected;
  final Function onTap;
  MyListTile({Key key, @required this.title, @required this.icon, this.onTap, this.selected = false, this.cargando = false}) : super(key: key);
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
          onTap: widget.onTap,
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          dense: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Icon(widget.icon, color: widget.selected ? Utils.colorPrimaryBlue : Colors.grey.shade700,),
          ),
          
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(widget.title, style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w500,fontSize: 14.3, letterSpacing: 0.2, color: widget.selected ? Utils.colorPrimaryBlue : Colors.grey.shade700)),
            Visibility(visible: widget.cargando, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Visibility(
                        visible: widget.cargando,
                        child: Theme(
                          data: Theme.of(context).copyWith(accentColor: Utils.colorPrimary),
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),)
          ],)
        )
    );
  }
}