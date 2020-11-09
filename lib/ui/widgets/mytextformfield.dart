import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';

class MyTextFormField extends StatefulWidget {
  final String title;
  final String sideTitle;
  final String labelText;
  final TextEditingController controller;
  final String hint;
  final maxLines;
  final bool enabled;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double padding;

  final bool isRequired;
  MyTextFormField({Key key, this.title = "", this.sideTitle, this.labelText = "", this.controller, this.hint, this.maxLines = 1, this.enabled = true, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8, this.isRequired = false}) : super(key: key);
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
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
          child: 
          (widget.sideTitle.isNotEmpty)
          ?
          Container(
            // color: Colors.red,
            width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Flexible(flex: 2, child: Visibility(visible: widget.sideTitle != "",child: Text(widget.sideTitle, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),))),
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
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            border: new OutlineInputBorder(
                              // borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          validator: (data){
                            if(data.isEmpty && widget.isRequired)
                              return "Campo requerido";
                            return null;
                          },
                        ),
              )
            ],
            ),
          )
          :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(visible: widget.title != "",child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),)),
              Container(
                // color: Colors.red,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
                // ),
                width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
                // height: 50,
                child:
                (widget.labelText == "")
                ?
                 TextFormField(
                   enabled: widget.enabled,
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
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
                      validator: (data){
                        if(data.isEmpty && widget.isRequired)
                          return "Campo requerido";
                        return null;
                      },
                    )
                  :
                  TextFormField(
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
                    style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        labelText: widget.labelText
                      ),
                      validator: (data){
                        if(data.isEmpty && widget.isRequired)
                          return "Campo requerido";
                        return null;
                      },
                    ),
              ),
            ],
          ),
        );
      }
    );
  }
}