import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyResizedContainer extends StatefulWidget {
  final Widget child;
  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double padding;
  final Color color;

  final bool isRequired;
  MyResizedContainer({Key key, this.child, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8, this.isRequired = false, this.color = Colors.transparent}) : super(key: key);
  @override
  _MyResizedContainerState createState() => _MyResizedContainerState();
}

class _MyResizedContainerState extends State<MyResizedContainer> {
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
        // print("mytextformfield boxconstrants: ${boxconstraints.maxWidth}");
        return Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Container(
                color: widget.color,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
                // ),
                width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
                // height: 50,
                child: widget.child
              )
        );
      }
    );
  }
}