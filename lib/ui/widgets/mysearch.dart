import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/classes/utils.dart';
// import 'package:loterias/core/models/cliente.dart';
// import 'package:loterias/core/services/customerservice.dart';
import 'package:rxdart/rxdart.dart';

class MySearchField extends StatefulWidget {
  final ValueChanged<Object> onSelected;
  final ValueChanged<String> onChanged;
  final String title;
  final String labelText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final maxLines;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  final double padding;

  final bool isRequired;
  MySearchField({Key key, this.title = "", this.labelText = "", this.controller, this.focusNode, this.onSelected, this.onChanged, this.hint, this.maxLines = 1, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8, this.isRequired = false}) : super(key: key);
  @override
  _MySearchFieldState createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  FocusNode _myFocus = FocusNode();
  bool _tieneFoco = false;
  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
    _myFocus.addListener(focusChanged);
    super.initState();
  }

  focusChanged(){
    // if (_myFocus.hasFocus) {

    //     // this._overlayEntry = this._createOverlayEntry();
    //     // Overlay.of(context).insert(this._overlayEntry);

    //   } else {
    //     this._overlayEntry.remove();
    //   }
    print('mysearch focusChange: ${_myFocus.hasFocus}');
    setState(() => _tieneFoco = _myFocus.hasFocus);

  }

  textChanged(String data) async {
    print("textChanged ${data.isEmpty}");
    // if (data.isNotEmpty) {
        if(widget.onChanged != null)
          widget.onChanged(data);

      // } 
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
        print("mytextformfield boxconstrants: ${boxconstraints.maxWidth}");
        return Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(visible: widget.title != "",child: Text(widget.title, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),)),
              Container(
                      // duration: Duration(milliseconds: 100),
                      // padding: EdgeInsets.all(3.0),
                      decoration:
                      _tieneFoco 
                      ?
                       BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            // spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 1.0), // changes position of shadow
                          ),
                        ],
                      )
                      :
                      BoxDecoration(
                        color: Utils.fromHex("#f1f3f4"),
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
                      )
                      ,
                      width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
                      // height: 50,
                      child:
                      (widget.labelText == "")
                      ?
                       Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                             child: Icon(Icons.search),
                           ),
                           Expanded(
                             child: TextFormField(
                               focusNode: _myFocus,
                                controller: widget.controller,
                                maxLines: widget.maxLines,
                                keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
                                style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: widget.hint,
                                    hintStyle: TextStyle(color: Utils.fromHex("#72777c"), fontWeight: FontWeight.w500),
                                    contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                                    isDense: true,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  validator: (data){
                                    if(data.isEmpty && widget.isRequired)
                                      return "Campo requerido";
                                    return null;
                                  },
                                  onChanged: (data){
                                    textChanged(data);
                                  },
                                ),
                           ),
                         ],
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
                    
              
              
              // Container(
              //         // duration: Duration(milliseconds: 100),
              //         padding: EdgeInsets.all(3.0),
              //         decoration:
              //         _tieneFoco 
              //         ?
              //          BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           // border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               // spreadRadius: 2,
              //               blurRadius: 2,
              //               offset: Offset(0, 1.0), // changes position of shadow
              //             ),
              //           ],
              //         )
              //         :
              //         BoxDecoration(
              //           color: Utils.fromHex("#f1f3f4"),
              //           borderRadius: BorderRadius.circular(10),
              //           // border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
              //         )
              //         ,
              //         width: getWidth(boxconstraints.maxWidth) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
              //         // height: 50,
              //         child:
              //         (widget.labelText == "")
              //         ?
              //          Row(
              //            children: [
              //              Icon(Icons.search),
              //              Expanded(
              //                child: TextFormField(
              //                  focusNode: widget.focusNode,
              //                   controller: widget.controller,
              //                   maxLines: widget.maxLines,
              //                   keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
              //                   style: TextStyle(fontSize: 15),
              //                     decoration: InputDecoration(
              //                       hintText: widget.hint,
              //                       hintStyle: TextStyle(color: Utils.fromHex("#72777c"), fontWeight: FontWeight.w500),
              //                       contentPadding: EdgeInsets.all(10),
              //                       isDense: true,
              //                       border: InputBorder.none,
              //                       focusedBorder: InputBorder.none,
              //                       enabledBorder: InputBorder.none,
              //                       errorBorder: InputBorder.none,
              //                       disabledBorder: InputBorder.none,
              //                     ),
              //                     validator: (data){
              //                       if(data.isEmpty && widget.isRequired)
              //                         return "Campo requerido";
              //                       return null;
              //                     },
              //                   ),
              //              ),
              //            ],
              //          )
              //           :
              //           TextFormField(
              //             controller: widget.controller,
              //             maxLines: widget.maxLines,
              //             keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
              //             style: TextStyle(fontSize: 15),
              //               decoration: InputDecoration(
              //                 labelText: widget.labelText
              //               ),
              //               validator: (data){
              //                 if(data.isEmpty && widget.isRequired)
              //                   return "Campo requerido";
              //                 return null;
              //               },
              //             ),
              //       ),
                  
             
            ],
          ),
        );
      }
    );
  }
}