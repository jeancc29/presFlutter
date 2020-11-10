import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

myButton({@required function, @required String text, Color color, Color letterColor}){
  return InkWell(
    onTap: function,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.only(top: 9.0, bottom: 9.0, right: 23, left: 23.0),
      decoration: BoxDecoration(
        color: (color == null) ? Utils.colorPrimaryBlue : color,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(text, style: TextStyle(color: (letterColor != null) ? letterColor : Colors.white, fontFamily: "Roboto", fontWeight: FontWeight.w600),)
    )
  );
}