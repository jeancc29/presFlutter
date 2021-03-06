import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';

class MyEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String titleButton;
  final Function onTap;
  final Widget customButtom;

  MyEmpty({Key key, this.icon, this.title = '', this.titleButton = '', this.onTap, this.customButtom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(icon),
        ),
        MyDescripcon(title: title),
        (customButtom != null)
        ?
        customButtom
        :
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: FlatButton(onPressed: onTap, child: Text(titleButton, style: TextStyle(color: Utils.colorPrimaryBlue, fontFamily: "GoogleSans", letterSpacing: 0.4),)),
        )
      ],
    );
  }
}