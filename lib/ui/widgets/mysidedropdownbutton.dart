import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';


class MySideDropdownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final List<String> elements;
  final String title;
  final ScreenSizeType whenBeSmall;
  final bool enabled;
  final String initialValue;


  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final EdgeInsets padding;

  MySideDropdownButton({Key key, @required this.title, @required this.onChanged, @required this.elements, this.initialValue, this.whenBeSmall, this.enabled = true, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = const EdgeInsets.only(left: 8.0, right: 8.0),}) : super(key: key);
  @override
  _MySideDropdownButtonState createState() => _MySideDropdownButtonState();
}

class _MySideDropdownButtonState extends State<MySideDropdownButton> {
  double _width;
  ScreenSizeType whenBeSmall;
  int _index = 0;
 

  _initialValue(){
    if(widget.initialValue != null){
      if(widget.elements.length > 0){
        var idx = widget.elements.indexWhere((element) => element == widget.initialValue);
        if(idx != -1)
          _index = idx;
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
    if(widget.whenBeSmall != null)
      whenBeSmall = widget.whenBeSmall;
    else
      whenBeSmall = ScreenSizeType.sm;
    _initialValue();


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
          child: DropdownButton(
            disabledHint: Text(""),
              isExpanded: true, 
              items: widget.elements.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(), 
              onChanged:(!widget.enabled) ? null : (data){
                if(widget.onChanged != null)
                  widget.onChanged(data);
                int idx = widget.elements.indexWhere((element) => element == data);
                setState(() => _index = idx);
              }, 
              value: widget.elements[_index],
            )
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
          MyDropdownButton(title: widget.title, onChanged: widget.onChanged, elements: widget.elements, small: widget.small, medium: widget.medium, large: widget.large, xlarge: widget.xlarge,)
          :
          _screen(boxconstraints.maxWidth)
        );
      }
    );
  }
}