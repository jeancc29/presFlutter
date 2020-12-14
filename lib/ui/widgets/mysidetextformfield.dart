import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';


class MySideTextFormField extends StatefulWidget {
  final String title;
  final ScreenSizeType whenBeSmall;
  final String labelText;
  final TextEditingController controller;
  final String hint;
  final maxLines;
  final bool enabled;
  final ValueChanged<String> validator;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final EdgeInsets padding;

  final bool isRequired;
  MySideTextFormField({Key key, this.title = "", this.whenBeSmall, this.labelText = "", this.controller, this.hint, this.maxLines = 1, this.enabled = true, this.validator, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(left: 8.0, right: 8.0), this.isRequired = false}) : super(key: key);
  @override
  _MySideTextFormFieldState createState() => _MySideTextFormFieldState();
}

class _MySideTextFormFieldState extends State<MySideTextFormField> {
  double _width;
  ScreenSizeType whenBeSmall;
  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
    if(widget.whenBeSmall != null)
      whenBeSmall = widget.whenBeSmall;
    else
      whenBeSmall = ScreenSizeType.sm;

    super.initState();
  }

  getWidth(double screenSize){
    double width = 0;
    if(ScreenSize.isSmall(screenSize))
      width = (widget.small != null) ? screenSize / widget.small : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isMedium(screenSize))
      width = (widget.medium != null) ? screenSize / widget.medium : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isLarge(screenSize))
      width = (widget.large != null) ? screenSize / widget.large : screenSize / getNotNullScreenSize();
    else if(ScreenSize.isXLarge(screenSize))
      width = (widget.xlarge != null) ? screenSize / widget.xlarge : screenSize / getNotNullScreenSize();
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

  _screen(double width){
    return Container(
      // color: Colors.red,
      width: getWidth(width) - (widget.padding.left + widget.padding.right), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Flexible(flex: 2, child: Visibility(visible: widget.title != "",child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),))),
        Flexible(
          flex: 4,
          child: TextFormField(
            enabled: widget.enabled,
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
            style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: widget.hint,
                // contentPadding: EdgeInsets.all(10),
                isDense: true,
                border: new OutlineInputBorder(
                  // borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: 
              (widget.validator != null)
              ?
              widget.validator
              :
              (data){
                if(data.isEmpty && widget.isRequired)
                  return "Campo requerido";
                return null;
              },
            ),
          )
      ],
      ),
    );
          
  }

  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        // print("mytextformfield boxconstrants: ${boxconstraints.maxWidth}");
        return Padding(
          padding: widget.padding,
          child: 
          (whenBeSmall.toString() == ScreenSize.isType(boxconstraints.maxWidth).toString())
          ?
          MyTextFormField(
            title: widget.title, 
            controller: widget.controller, 
            small: widget.small, 
            medium: widget.medium, 
            large: widget.large, 
            xlarge: widget.xlarge, 
            isRequired: widget.isRequired,
            validator: (widget.validator != null) 
            ?
            widget.validator
            :
            null
            )

          :
          _screen(boxconstraints.maxWidth)
        );
      }
    );
  }
}