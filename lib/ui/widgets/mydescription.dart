import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

class MyDescripcon extends StatelessWidget {
  final String title;
  MyDescripcon({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: Utils.fromHex("#5f6368"), fontSize: 13, letterSpacing: 0.2),);
  }
}