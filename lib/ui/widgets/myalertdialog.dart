import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';


class MyAlertDialog extends StatefulWidget {
  final String title;
  final String description;
  final Wrap content;
  final String okDescription;
  final Function okFunction;
  final bool cargando;

  final double small;
  final double medium;
  final double large;
  final double xlarge;
  // final double padding;

  MyAlertDialog({Key key, @required this.title, @required this.content, this.description, this.okDescription = "Ok", @required this.okFunction, this.cargando = false, this.small = 1, this.medium = 1.6, this.large = 2.5, this.xlarge = 2.5,}) : super(key: key);
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
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
   
    print("myalertDialog size type: ${ScreenSize.isType(screenSize)} : $screenSize : x = ${widget.xlarge}");
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
    return LayoutBuilder(
      builder: (context, boxconstraints){
        
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              titlePadding: EdgeInsets.only(left: 24, right: 15, top: 10),
              contentPadding: EdgeInsets.fromLTRB(24.0, 0, 15.0, 5.0),
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )
              ,
              content: SingleChildScrollView(
                child: Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  // width: MediaQuery.of(context).size.width / 2.5,
                  width: getWidth(width),
                  child: Wrap(
                    children: [
                      
                 
                       Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 14, right: 3.0),
                        child: Text(widget.description, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.65),),),
                      ),
                      widget.content,
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: widget.cargando,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: (){Navigator.pop(context);}),
                            ),
                          // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                              child: AbsorbPointer(
                                absorbing: widget.cargando,
                                child:  myButton(
                                text: "Ok",
                                function: widget.okFunction, 
                                color: (widget.cargando) ? Colors.grey[300] : null,
                                letterColor: (widget.cargando) ? Colors.grey : null,
                              ),
                              )
                            ),
                                ],
                              )
                            )
            
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),
            //   actions: [
            //     Visibility(
            //       visible: widget.cargando,
            //       child: Align(
            //         alignment: Alignment.topLeft,
            //         child: CircularProgressIndicator(),
            //       ),
            //     ),
            //   Padding(
            //     padding: const EdgeInsets.only(bottom: 10.0),
            //     child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: (){Navigator.pop(context);}),
            //   ),
            // // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
            //   Padding(
            //     padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            //     child: myButton(
            //       text: "Ok",
            //       function: widget.okFunction, 
            //     ),
            //   ),
            
            //   ],
            );
          }
        );
      
    //     Container(
    //   // color: Colors.red,
    //   // decoration: BoxDecoration(
    //   //   borderRadius: BorderRadius.circular(10),
    //   //   border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid)
    //   // ),
    //   width: getWidth(width) - (widget.padding * 2), //El padding se multiplica por dos ya que el padding dado es el mismo para la izquiera y derecha
    //   // height: 50,
    //   child:
    //   (widget.labelText == "")
    //   ?
    //    TextFormField(
    //      enabled: widget.enabled,
    //       controller: widget.controller,
    //       maxLines: widget.maxLines,
    //       keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
    //       style: TextStyle(fontSize: 15),
    //         decoration: InputDecoration(
    //           hintText: widget.hint,
    //           contentPadding: EdgeInsets.all(10),
    //           isDense: true,
    //           border: new OutlineInputBorder(
    //             // borderRadius: new BorderRadius.circular(25.0),
    //             borderSide: new BorderSide(),
    //           ),
    //         ),
    //         validator: (data){
    //           if(data.isEmpty && widget.isRequired)
    //             return "Campo requerido";
    //           return null;
    //         },
    //       )
    //     :
    //     TextFormField(
    //       controller: widget.controller,
    //       maxLines: widget.maxLines,
    //       keyboardType: (widget.maxLines != 1) ? TextInputType.multiline : null,
    //       style: TextStyle(fontSize: 15),
    //         decoration: InputDecoration(
    //           labelText: widget.labelText
    //         ),
    //         validator: (data){
    //           if(data.isEmpty && widget.isRequired)
    //             return "Campo requerido";
    //           return null;
    //         },
    //       ),
    // );
          
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxconstraints) {
        // print("mytextformfield boxconstrants: ${boxconstraints.maxWidth}");
        return _screen(boxconstraints.maxWidth);
      }
    );
  }
}