import 'package:flutter/material.dart';

class MySubtitle extends StatefulWidget {
  final String title;
  final double fontSize;
  MySubtitle({Key key, @required this.title, this.fontSize = 20}) : super(key: key);
  @override
  _MySubtitleState createState() => _MySubtitleState();
}

class _MySubtitleState extends State<MySubtitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.title, style: TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}