import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/services/customerservice.dart';
import 'package:rxdart/rxdart.dart';

class MySearchField extends StatefulWidget {
  final ValueChanged<Cliente> onSelected;
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
  MySearchField({Key key, this.title = "", this.labelText = "", this.controller, this.focusNode, this.onSelected, this.hint, this.maxLines = 1, this.small = 1, this.medium = 3, this.large = 4, this.xlarge = 5, this.padding = 8, this.isRequired = false}) : super(key: key);
  @override
  _MySearchFieldState createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  double _width;
  FocusNode _myFocus = FocusNode();
  bool _tieneFoco = false;
  StreamController<List<Cliente>> _streamController;
  List<String> lista = ["Jean", "Carlos", "Contreras", "Manuel", "Pedro", "Estefania"];

  OverlayEntry _overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    // _width = getWidth();
    _streamController = BehaviorSubject();
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
    setState(() => _tieneFoco = _myFocus.hasFocus);
  }

  textChanged(String data) async {
    print("textChanged ${data.isEmpty} ${this._overlayEntry == null}");
    if (data.isNotEmpty) {
        if(this._overlayEntry == null){
          this._overlayEntry = this._createOverlayEntry2();
          Overlay.of(context).insert(this._overlayEntry);
          // List<String> resultados = lista.where((element) => element.toLowerCase().indexOf(data) != -1).toList();
          _streamController.add(await _search(data));
        }else{
          //  List<String> resultados = lista.where((element) => element.toLowerCase().indexOf(data) != -1).toList();
          _streamController.add(await _search(data));
        }

      } else {
        this._overlayEntry.remove();
        this._overlayEntry = null;
      }
    // setState(() => _tieneFoco = _myFocus.hasFocus);
  }

 Future<List<Cliente>> _search(String data) async {
    try {
      var parsed = await CustomerService.search(context: context, data: data);
      List<Cliente> listaCliente = parsed["clientes"].map<Cliente>((json) => Cliente.fromMap(json)).toList();
      return listaCliente;
    } catch (e) {
      print("Mysearch _search error: ${e.toString()}");
      return List();
    }
  }

  OverlayEntry _createOverlayEntry() {

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + widget.padding,
        top: offset.dy + size.height - widget.padding,
        width: getWidth(size.width) - (widget.padding * 2),
        child:
        Material(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  // spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1.0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text("Jean Carlos Contreras"),
                  subtitle: Text("031-0563805-8"),
                ),
                ListTile(
                  title: Text("Jean Carlos Contreras"),
                  subtitle: Text("031-0563805-8"),
                ),
                ListTile(
                  title: Text("Jean Carlos Contreras"),
                  subtitle: Text("031-0563805-8"),
                ),
              ],
            
            ),
          ),
        )
        //  Material(
        //   elevation: 4.0,
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     shrinkWrap: true,
        //     children: <Widget>[
        //       ListTile(
        //         title: Text('Syria'),
        //       ),
        //       ListTile(
        //         title: Text('Lebanon'),
        //       )
        //     ],
        //   ),
        // ),
      )
    );
  }

  OverlayEntry _createOverlayEntry2() {

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + widget.padding,
        top: offset.dy + size.height - widget.padding,
        width: getWidth(size.width) - (widget.padding * 2),
        child:
        Material(
          elevation: 4,
          child: StreamBuilder<List<Cliente>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData)
                return _myContainer(snapshot.data);
              else
                return Center(child: CircularProgressIndicator());
            }
          ),
        )
        //  Material(
        //   elevation: 4.0,
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     shrinkWrap: true,
        //     children: <Widget>[
        //       ListTile(
        //         title: Text('Syria'),
        //       ),
        //       ListTile(
        //         title: Text('Lebanon'),
        //       )
        //     ],
        //   ),
        // ),
      )
    );
  }

  _myContainer(List<Cliente> data){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        // border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            // spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1.0), // changes position of shadow
          ),
        ],
      ),
      child: 
      data.isEmpty
      ?
      Center(child: Text("No hay coincidencias"))
      :
      SingleChildScrollView(
        child: Column(
          children: data.map((e) => ListTile(
          title: Text("${e.nombres} ${e.apellidos}"),
          subtitle: Text("${e.documento == null ? '01' : e.documento.descripcion}"),
          onTap: (){_selectClienteAndClose(e);},
        )).toList(),
        ),
      ),
    );
  }

  _selectClienteAndClose(Cliente cliente){
    if(this._overlayEntry != null){
      this._overlayEntry.remove();
      this._overlayEntry = null;
    }

    widget.controller.text = cliente.nombres;
    widget.onSelected(cliente);
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
                      padding: EdgeInsets.all(3.0),
                      decoration:
                      _tieneFoco 
                      ?
                       BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                           Icon(Icons.search),
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
                                    contentPadding: EdgeInsets.all(10),
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