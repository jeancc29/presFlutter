import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';

class MyButtonType {
  const MyButtonType._(this.index);

  /// The encoded integer value of this font weight.
  final int index;

  /// Thin, the least thick
  static const MyButtonType normal = MyButtonType._(0);

  /// Extra-light
  static const MyButtonType roundedWithOnlyBorder = MyButtonType._(1);

  /// Light
  static const MyButtonType rounded = MyButtonType._(2);

  /// A list of all the font weights.
  static const List<MyButtonType> values = <MyButtonType>[
    normal, roundedWithOnlyBorder, rounded
  ];
}


class MyButton extends StatefulWidget {
  final String title;
  final bool enabled;
  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final EdgeInsets padding;

  final Function function;
  final Color color;
  final Color textColor;
  final MyButtonType type;
  final double letterSpacing;
  final Widget leading;
  final bool cargando;
  final ValueNotifier<bool> cargandoNotify;

  MyButton({Key key, this.title = "", this.function, this.enabled = true, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(top: 9.0, bottom: 9.0, right: 23, left: 23.0), this.color, this.textColor, this.type = MyButtonType.normal, this.leading, this.letterSpacing = 0.4, this.cargando = false, this.cargandoNotify}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {

  Color _color(){
    switch (widget.type) {
      case MyButtonType.rounded:
        if(widget.color == null){
          return (widget.enabled) ? Utils.colorPrimaryBlue : Colors.grey[300];
        }else{
          return (widget.enabled) ? widget.color : Colors.grey[300];
        }
        break;
      case MyButtonType.roundedWithOnlyBorder:
        if(widget.color == null){
          return  Colors.white;
        }else{
          return  widget.color;
        }
        break;
      default:
      if(widget.color == null){
        return (widget.enabled) ? Utils.colorPrimaryBlue : Colors.grey[300];
      }else{
        return (widget.enabled) ? widget.color : Colors.grey[300];
      }
    }
  }

  Color _textColor(){
    switch (widget.type) {
      case MyButtonType.roundedWithOnlyBorder:
        if(widget.textColor == null){
          return (widget.enabled) ? Colors.blue : Colors.grey;
        }else{
          return (widget.enabled) ? widget.textColor : Colors.grey;
        }
        break;
      default:
        if(widget.textColor == null){
          return (widget.enabled) ? Colors.white : Colors.grey;
        }else{
          return (widget.enabled) ? widget.textColor : Colors.grey;
        }
    }
  }

  _buttonNormal(){
    return InkWell(
    onTap: widget.function,
    child: MyResizedContainer(
      small: widget.small,
      medium: widget.medium,
      large: widget.large,
      xlarge: widget.xlarge,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _color(),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: Text(widget.title, style: TextStyle(color: _textColor(), fontFamily: "GoogleSans", fontWeight: FontWeight.w600),))
      ),
    )
  );
  }

  _buttonRoundedWithOnlyBorder(){
    return InkWell(
    onTap: widget.function,
    child: MyResizedContainer(
      small: widget.small,
      medium: widget.medium,
      large: widget.large,
      xlarge: widget.xlarge,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _color(),
          border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
        ),
        child: (widget.leading == null) 
        ? 
        Center(child: Text(widget.title.toUpperCase(), style: TextStyle(color: _textColor(), fontFamily: "GoogleSans", fontWeight: FontWeight.w600, letterSpacing: widget.letterSpacing),))
        :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.leading,
             Center(child: Text(widget.title.toUpperCase(), style: TextStyle(color: _textColor(), fontFamily: "GoogleSans", fontWeight: FontWeight.w600, letterSpacing: widget.letterSpacing),))

          ],
        )
      ),
    )
  ); 
  }

  _buttonRounded(){
    return InkWell(
    onTap: widget.function,
    child: MyResizedContainer(
      small: widget.small,
      medium: widget.medium,
      large: widget.large,
      xlarge: widget.xlarge,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _color(),
          border: Border.all(color: _color().withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // color: _color().withOpacity(0.4),
              color: _color(),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
        ),
        child: Center(
          child: 
           (widget.cargandoNotify == null) 
              ? 
              (widget.cargando)
              ?
              CircularProgressIndicator(backgroundColor: widget.textColor,) 
              : 
              Text(widget.title.toUpperCase(), style: TextStyle(color: _textColor(), fontFamily: "GoogleSans", fontWeight: FontWeight.w600, letterSpacing: widget.letterSpacing),)
          :
          ValueListenableBuilder(
            valueListenable: widget.cargandoNotify,
            builder: (_, value, __){
              return (value) 
              ? 
              CircularProgressIndicator(backgroundColor: widget.textColor,) 
              : 
              Text(widget.title.toUpperCase(), style: TextStyle(color: _textColor(), fontFamily: "GoogleSans", fontWeight: FontWeight.w600, letterSpacing: widget.letterSpacing),);
            },
          )
        )
      ),
    )
  ); 
  }


  _screen(){
    switch (widget.type) {
      case MyButtonType.roundedWithOnlyBorder:
        return _buttonRoundedWithOnlyBorder();
        break;
      case MyButtonType.rounded:
        return _buttonRounded();
        break;
      default:
        return _buttonNormal();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(widget.cargandoNotify != null)
      widget.cargandoNotify.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("mybutton2 build");
    return _screen();
  }
}