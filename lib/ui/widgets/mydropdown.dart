import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return MyResizedContainer(
      xlarge: 3.9,
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_today_outlined, color: Utils.fromHex("#1967d2"),),
            Text("Ultimos 30 dias", style: TextStyle(fontFamily: "GoogleSans", color: Utils.fromHex("#1967d2"), fontWeight: FontWeight.w700)),
            Icon(Icons.arrow_drop_down, color: Utils.fromHex("#1967d2")),
          ],
        ),
      ),
    );
  }
}