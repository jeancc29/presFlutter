import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/services/boxservice.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:rxdart/rxdart.dart';

class CajasScreen extends StatefulWidget {
  @override
  _CajasScreenState createState() => _CajasScreenState();
}

class _CajasScreenState extends State<CajasScreen> {
  bool _cargando = false;
  var _formKey = GlobalKey<FormState>();
  StreamController<List<Caja>> _streamController;
  var _txtDescripcion = TextEditingController();
  bool _ckbValidarDesgloseEfectivo = false;
    bool _ckbValidarDesgloseCheques = false;
    bool _ckbValidarDesgloseTarjetas = false;
    bool _ckbValidarDesgloseTransferencias = false;

  List<Caja> lista = List();
  Caja _caja = new Caja();
  _back() async {
    Navigator.pop(context);
  }

  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await BoxService.index(context: context);
      print("_init: $parsed");
      lista = (parsed["cajas"] != null) ? parsed["cajas"].map<Caja>((json) => Caja.fromMap(json)).toList() : List<Caja>();
      for(Caja c in lista){
        print("Nombre: ${c.descripcion}");
      }
     _streamController.add(lista);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de cusomerservice index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _store() async {
    // try {
      // setState(() => _cargando = true);
      _caja.descripcion = _txtDescripcion.text;
      _caja.validarDesgloseEfectivo = _ckbValidarDesgloseEfectivo;
      _caja.validarDesgloseCheques = _ckbValidarDesgloseCheques;
      _caja.validarDesgloseTarjetas = _ckbValidarDesgloseTarjetas;
      _caja.validarDesgloseTransferencias = _ckbValidarDesgloseTransferencias;
      var parsed = await BoxService.store(context: context, caja: _caja);
      print("_store: $parsed");
      _insertCajaTolistas(parsed);
     
      // setState(() => _cargando = false);
    // } catch (e) {
    //   print("errorrrrrrrr de guardar index: ${e.toString()}");
    //   setState(() => _cargando = false);
    // }
  }

  _create(){
    _caja = new Caja();
    _txtDescripcion.text = '';
    _ckbValidarDesgloseEfectivo = false;
    _ckbValidarDesgloseCheques = false;
    _ckbValidarDesgloseTarjetas = false;
    _ckbValidarDesgloseTransferencias = false;
     _showDialogFormulario();
  }
   
   _update(Caja caja){
     _caja = caja;
     _txtDescripcion.text = _caja.descripcion;
     _ckbValidarDesgloseEfectivo = _caja.validarDesgloseEfectivo;
     _ckbValidarDesgloseCheques = _caja.validarDesgloseCheques;
     _ckbValidarDesgloseTarjetas = _caja.validarDesgloseTarjetas;
     _ckbValidarDesgloseTransferencias = _caja.validarDesgloseTransferencias;
     _showDialogFormulario();
   }

   _delete(Caja caja) async {
    try {
      
      var parsed = await BoxService.delete(context: context, caja: caja);
      print("_delete: $parsed");
      _deleteCajaFromlistas(parsed);
     _streamController.add(lista);
      
    } catch (e) {
      print("errorrrrrrrr de _delete index: ${e.toString()}");
      
    }
   }


  

  _insertCajaTolistas(Map<String, dynamic> parsed){
    if(parsed["caja"] != null){
        Caja caja = Caja.fromMap(parsed["caja"]);
        
        int index = lista.indexWhere((element) => element.id == caja.id);
        if(index == -1){
          print("_insertCajaTolistas: ${caja.toJson()}");
          lista.add(caja);
          _streamController.add(lista);
        }else{
          print("_insertCajaTolistas2: ${caja.toJson()}");
          lista[index].descripcion = caja.descripcion;
          _streamController.add(lista);
        }
      }
  }

  _deleteCajaFromlistas(Map<String, dynamic> parsed){
    if(parsed["caja"] != null){
        Caja caja = Caja.fromMap(parsed["caja"]);
        Caja cajaAEliminar = lista.firstWhere((element) => element.id == caja.id);
        if(cajaAEliminar != null)
          lista.remove(cajaAEliminar);
      }
  }

  _closeDialog(){
    Navigator.pop(context);
  }

  


  _showDialogFormulario(){
    print("Holaa");

    
    // return;
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {
            _ckbValidarDesgloseEfectivoChanged(bool data){
              setState(() => _ckbValidarDesgloseEfectivo = data);
            }
            _ckbValidarDesgloseChequesChanged(bool data){
              setState(() => _ckbValidarDesgloseCheques = data);
            }
            _ckbValidarDesgloseTarjetasChanged(bool data){
              setState(() => _ckbValidarDesgloseTarjetas = data);
            }
            _ckbValidarDesgloseTransferenciasChanged(bool data){
              setState(() => _ckbValidarDesgloseTransferencias = data);
            }

            return AlertDialog(
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Guardar caja", style: TextStyle(fontSize: 24, fontFamily: "Roboto", fontWeight: FontWeight.w700)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Visibility(
                        visible: _cargando,
                        child: Theme(
                          data: Theme.of(context).copyWith(accentColor: Utils.colorPrimary),
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Form(
                key: _formKey,
                child: Wrap(
                  children: [
                    TextFormField(
                      controller: _txtDescripcion,
                      decoration: InputDecoration(labelText: "Descripcion *"),
                      validator: (String data){
                        if(data.isEmpty)
                          return "Campo vacio";

                        return null;
                      },
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Validar", style: TextStyle(fontSize: 20, fontFamily: "Roboto", fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Wrap(
                      children: [
                        MyCheckBox(title: "Desglose de efectivo", value: _ckbValidarDesgloseEfectivo, onChanged: _ckbValidarDesgloseEfectivoChanged, padding: 0,  medium: 2,),
                        MyCheckBox(title: "Desglose de cheques", value: _ckbValidarDesgloseCheques, onChanged: _ckbValidarDesgloseChequesChanged, padding: 0,  medium: 2,),
                        MyCheckBox(title: "Desglose de tarjetas", value: _ckbValidarDesgloseTarjetas, onChanged: _ckbValidarDesgloseTarjetasChanged, padding: 0,  medium: 2,),
                        MyCheckBox(title: "Desglose de transferenci", value: _ckbValidarDesgloseTransferencias, onChanged: _ckbValidarDesgloseTransferenciasChanged, padding: 0,  medium: 2,),
                      ],
                    ),
                    
                    
                    
                  ],
                ))
              ),
              actions: [
              FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold)), onPressed: _closeDialog),
            // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
            SizedBox(
              width: 145,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RaisedButton(
                    elevation: 0,
                    color: Utils.colorPrimaryBlue,
                    child: Text('Agregar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      // _connect();
                      if(_formKey.currentState.validate()){
                        // try {
                            setState(() => _cargando = true);
                              await _store();
                              _back();
                              setState(() => _cargando = false);
                              
                          // } catch (e) {
                          //   setState(() => _cargando = false);
                          // }
                      }
                    },
                ),
              ),
            ),
              ],
            );
          }
        );
      }
    );
  }

  _showDialogConfirmarEliminacion(Caja caja){
     showDialog(context: context, builder: (context){
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eliminar caja"),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Visibility(
                            visible: _cargando,
                            child: Theme(
                              data: Theme.of(context).copyWith(accentColor: Utils.colorPrimary),
                              child: new CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
             content: Text("Seguro desea eliminar la ruta ${caja.descripcion}?"),
             actions: [
               FlatButton(onPressed: _back, child: Text("Cancelar")),
               FlatButton(onPressed: () async {
                //  try {
                   setState(() => _cargando = true);
                    await _delete(caja);
                    setState(() => _cargando = false);
                    _back();
                //  } catch (e) {
                //    setState(() => _cargando = false);
                //  }
               }, child: Text("Ok")),
             ],
           );
         }
       );
     });
   }

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      body: [
        MyHeader(title: "Cajas", subtitle: "Administre todas sus cajas", function: _create, actionFuncion: "Agregar",),
        Expanded(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     padding: EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey.shade300,  width: 0.9),
              //       borderRadius: BorderRadius.circular(5)
              //     ),
              //     child: Row(children: [
              //       Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text("Caja1", style: TextStyle(fontSize: 20),)
              //             ],
              //           ),
              //         ],
              //       )
              //     ],),
              //   ),
              // ),
              SizedBox(height: 20,),
              // Text("Diseno 1", style: TextStyle(fontSize: 20),),
              SizedBox(height: 2,),
              StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot){
                  if(snapshot.hasData && lista.length > 0)
                    return Expanded(
                      child: ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){_update(lista[index]);},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300,  width: 0.9),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: ListTile(
                                      // selected: true,
                                      title: Text(lista[index].descripcion),
                                      subtitle: Text("\$RD ${lista[index].balanceInicial}"),
                                      // trailing: Icon(Icons.more_horiz, size: 30,),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete, size: 30),
                                        onPressed: (){
                                          _showDialogConfirmarEliminacion(lista[index]);
                                        },
                                      ),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    );

                    return Center(
                      child: Text("No hay datos"),
                    );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey.shade300,  width: 0.9),
              //       borderRadius: BorderRadius.circular(10)
              //     ),
              //     child: ListTile(
              //           title: Text("Caja 1"),
              //           subtitle: Text("\$RD 2,000.00"),
              //           trailing: Icon(Icons.delete, size: 30,),
              //         ),
              //   ),
              // ),
              // SizedBox(height: 20,),
              // Text("Diseno 2", style: TextStyle(fontSize: 20),),
              // SizedBox(height: 2,),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //     child: ListTile(
              //       title: Text("Caja 1"),
              //       subtitle: Text("\$RD 2,000.00"),
              //       trailing: Icon(Icons.more_horiz, color: Utils.colorPrimaryBlue, size: 30,),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //     child: ListTile(
              //       title: Text("Caja 1"),
              //       subtitle: Text("\$RD 2,000.00"),
              //       trailing: Icon(Icons.more_horiz, color: Utils.colorPrimaryBlue, size: 30,),
              //     ),
              //   ),
              // ),
             
            ],
          ),
        )
      ]
    );
  }
}