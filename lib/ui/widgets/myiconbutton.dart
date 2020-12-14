import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';

myIconButton({@required function, @required IconData icon, Color color, Color iconColor}){
  return InkWell(
    onTap: function,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.only(top: 9.0, bottom: 9.0, right: 23, left: 23.0),
      decoration: BoxDecoration(
        color: (color == null) ? Utils.colorPrimaryBlue : color,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Icon(icon, color: (iconColor != null) ? iconColor : Colors.white,)
    )
  );
}