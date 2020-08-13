import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final double width;
  final String title;
  final TextEditingController controller;
  final String hint;
  MyTextFormField({Key key, @required this.width, @required this.title, this.controller, this.hint}) : super(key: key);
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, textAlign: TextAlign.start,),
        Container(
          // color: Colors.red,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
          // ),
          width: widget.width,
          // height: 50,
          child: TextFormField(
              controller: widget.controller,
              style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  border: new OutlineInputBorder(
                    // borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
        ),
      ],
    );
  }
}