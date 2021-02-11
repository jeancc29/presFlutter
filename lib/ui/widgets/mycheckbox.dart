import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyCheckBox extends StatefulWidget {
  final String title;
  final bool value;
  final Color color;
  final ValueChanged<bool> onChanged;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double padding;

  final bool isRequired;
  final bool disable;
  MyCheckBox({Key key, this.title = "", this.onChanged, this.value = false, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8, this.isRequired = false, this.color, this.disable = false}) : super(key: key);
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  double _width;
  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        return Padding(
          padding: EdgeInsets.all(widget.padding),
          child: 
          
              Container(
                // color: Colors.red,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
                // ),
                width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
                // height: 50,
                child: AbsorbPointer(
                  absorbing: widget.disable,
                  child: InkWell(
                    onTap: (){
                      widget.onChanged(!widget.value);
                    },
                    child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                  height: 8,
                                  child: Checkbox(
                                    // useTapTarget: false,
                                    activeColor: (!widget.disable) ? (widget.color != null) ? widget.color : null : Colors.grey,
                                    value: widget.value,
                                    onChanged: widget.onChanged,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Flexible(
                                  child: InkWell(
                                    onTap: (){
                                      widget.onChanged(!widget.value);
                                    },
                                    child: Text(widget.title,  overflow: TextOverflow.ellipsis, style: TextStyle(color: widget.disable ? Colors.grey : null)),
                                  ),
                                )
                              ],
                            ),
                  ),
                ),
                
              ),
            
        );
      }
    );
  }
}