import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';

class MyBottomSheet extends StatefulWidget {
  final Widget content;
  final String title;
  final String description;
  final Function okFunction;
  final String okFunctionDescription;
  final bool cargando;
  final double height;
  MyBottomSheet({Key key, @required this.content, @required this.title, this.description = "", this.okFunction, this.okFunctionDescription, this.cargando = false, this.height = 1.3}) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
     return Container(
              height: MediaQuery.of(context).size.height / widget.height,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.title}", style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w600, fontSize: 25)),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.description.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 1.0, bottom: 10),
                      child: MyDescripcon(title: "${widget.description}", fontSize: 16,),
                    ),
                  ),
                  Expanded(
                    child: 
                    (widget.content != null) 
                    ? Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SingleChildScrollView(child: widget.content),
                    ) 
                    : SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: widget.cargando,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                          ),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: (){Navigator.pop(context);}),
                            ),
                          // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, left: 10, right: 20),
                              child: AbsorbPointer(
                                  absorbing: widget.cargando,
                                  child:  myButton(
                                  text: "${widget.okFunctionDescription}",
                                  function: widget.okFunction, 
                                  color: (widget.cargando) ? Colors.grey[300] : null,
                                  letterColor: (widget.cargando) ? Colors.grey : null,
                                ),
                              )
                            ),
                          ],
                        )
            
                      ],
                    ),
                  )
                
                ]
              )
            );
        
  }
}

// myshowModalSheet({@required context, @required Widget content, @required String title, String description = "", Function okFunction, String okFunctionDescription = "Ok", bool cargando = false, double height = 1.3}){
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape:  RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       builder: (context){
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Container(
//               height: MediaQuery.of(context).size.height / height,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("$title", style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w600, fontSize: 25)),
//                         IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: (){
//                             Navigator.pop(context);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Visibility(
//                     visible: description.isNotEmpty,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15.0, top: 1.0, bottom: 10),
//                       child: MyDescripcon(title: "$description", fontSize: 16,),
//                     ),
//                   ),
//                   Expanded(
//                     child: 
//                     (content != null) 
//                     ? Padding(
//                       padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                       child: SingleChildScrollView(child: content),
//                     ) 
//                     : SizedBox(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 18.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Visibility(
//                           visible: cargando,
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
//                           ),
//                         ),
                        
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: (){Navigator.pop(context);}),
//                             ),
//                           // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                               child: AbsorbPointer(
//                                   absorbing: cargando,
//                                   child:  myButton(
//                                   text: "$okFunctionDescription",
//                                   function: okFunction, 
//                                   color: (cargando) ? Colors.grey[300] : null,
//                                   letterColor: (cargando) ? Colors.grey : null,
//                                 ),
//                               )
//                             ),
                           
//                           ],
//                         )
            
//                       ],
//                     ),
//                   )
                
//                 ]
//               )
//             );
//           }
//         );
        
//       }
//     );
                              
//   }
  