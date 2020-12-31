import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/prestamo.dart';
import 'package:prestamo/core/services/loanservice.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:rxdart/rxdart.dart';

class ShowPrestamo extends StatefulWidget {
  final Prestamo prestamo;
  ShowPrestamo({Key key, this.prestamo}) : super(key: key);
  @override
  _ShowPrestamoState createState() => _ShowPrestamoState();
}

class _ShowPrestamoState extends State<ShowPrestamo> {
  StreamController<Prestamo> _streamController;
  Prestamo _prestamo;

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  _init() async {
    var prestamo = await LoanService.show(context: context, prestamo: widget.prestamo);
    if(prestamo["prestamo"] != null){
      _prestamo = Prestamo.fromMap(prestamo["prestamo"]);
      print("_init Prestamo: ${_prestamo.toJson()}");
      _streamController.add(_prestamo);
    }
  }

  _pagar(){

  }

  _editar(){

  }

  _contrato(){

  }

  _exportar(){

  }


  @override
  Widget build(BuildContext context) {
    return myScaffold(
      cargando: false,
      context: context,
      prestamos: true,
      body: [
        MyHeader(
          title: "Detalle", 
          customFunction: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(children: [
              FlatButton(onPressed: _exportar, child: Text("Exportar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              FlatButton(onPressed: _contrato, child: Text("Contrato", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              FlatButton(onPressed: _editar, child: Text("Editar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              myButton(function: _pagar, text: "Pagar")
            ],),
          ),
        ),
        Expanded(
          child: StreamBuilder<Prestamo>(
            stream: _streamController.stream,
            builder: (context, snapshot){
              if(snapshot.hasData)
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: 
                        // ListTile(
                        //   leading: Utils.getCustomerPhoto(widget.prestamo.cliente.nombreFoto, size: 120),
                        //   title: Text("${snapshot.data.cliente.nombres} ${snapshot.data.cliente.apellidos}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, letterSpacing: 0.2, fontFamily: "GoogleSans"),),
                        //   subtitle: Text("031-0563805-4"),
                        // )
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Utils.getCustomerPhoto(widget.prestamo.cliente.nombreFoto, size: 80),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${snapshot.data.cliente.nombres} ${snapshot.data.cliente.apellidos}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, fontFamily: "GoogleSans"),),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Wrap(children: [
                                  MyDescripcon(title: "${snapshot.data.cliente.documento.descripcion}", fontSize: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                                    child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                                  ),
                                  MyDescripcon(title: "${snapshot.data.cliente.contacto.celular}", fontSize: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                                    child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                                  ),
                                  MyDescripcon(title: "${snapshot.data.cliente.contacto.correo}", fontSize: 15,),

                                ],),
                              )
                            ],
                          )
                        ],),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 23.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: MySubtitle(title: "Prestamo", fontSize: 18,),
                      ),
                      Wrap(
                        children: [
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Pagado", fontSize: 15,),
                                Text("${Utils.toCurrency(0)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Proximo pago", fontSize: 15,),
                                Text("0000-00-00", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Balance pendiente", fontSize: 15,),
                                Text("${Utils.toCurrency(snapshot.data.monto)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Cuotas", fontSize: 15,),
                                Text("0/${snapshot.data.numeroCuotas}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Prestado", fontSize: 15,),
                                Text("${Utils.toCurrency(snapshot.data.monto)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Interes", fontSize: 15,),
                                Text("${snapshot.data.porcentajeInteres}%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Mora", fontSize: 15,),
                                Text("${snapshot.data.porcentajeInteres}%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),

                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Plazo", fontSize: 15,),
                                Text("Mensual", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),
                          MyResizedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyDescripcon(title: "Amortizacion", fontSize: 15,),
                                Text("Insoluto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                                // MyDescripcon(title: "0/3", fontSize: 15,),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );

                return Center(child: CircularProgressIndicator(),);
            }
          ),
        )
      ]
    );
  }
}