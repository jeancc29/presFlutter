import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyTextFormField extends StatefulWidget {
  final double screenSize;
  final String title;
  final TextEditingController controller;
  final String hint;

  final int small;
  final int medium;
  final int large;
  final int xlarge;
  MyTextFormField({Key key, @required this.screenSize, @required this.title, this.controller, this.hint, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5}) : super(key: key);
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  double _width;
  @override
  void initState() {
    // TODO: implement initState
    _width = getWidth();
    super.initState();
  }

  getWidth(){
    double width = 0;
    if(ScreenSize.isSmall(widget.screenSize))
      width = (widget.small != null) ? widget.screenSize / widget.small : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isMedium(widget.screenSize))
      width = (widget.medium != null) ? widget.screenSize / widget.medium : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isLarge(widget.screenSize))
      width = (widget.large != null) ? widget.screenSize / widget.large : widget.screenSize / getNotNullScreenSize();
    else if(ScreenSize.isXLarge(widget.screenSize))
      width = (widget.xlarge != null) ? widget.screenSize / widget.xlarge : widget.screenSize / getNotNullScreenSize();
    return width;
    
  }
  getNotNullScreenSize(){
    
    if(widget.small != null)
      return widget.small;
    else if(widget.medium != null)
      return widget.medium;
    else if(widget.large != null)
      return widget.large;
    else
      return widget.xlarge;
  }

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
          width: _width,
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