import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/services/bankservice.dart';
import 'package:prestamo/core/services/boxservice.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:rxdart/rxdart.dart';

class BancosScreen extends StatefulWidget {
  @override
  _BancosScreenState createState() => _BancosScreenState();
}

class _BancosScreenState extends State<BancosScreen> {
  bool _cargando = false;
  var _formKey = GlobalKey<FormState>();
  StreamController<List<Banco>> _streamController;
  var _txtDescripcion = TextEditingController();
    bool _ckbEstado = false;

  List<Banco> lista = List();
  Banco _banco = new Banco();
  _back() async {
    Navigator.pop(context);
  }

  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await BankService.index(context: context);
      print("_init: $parsed");
      lista = (parsed["bancos"] != null) ? parsed["bancos"].map<Banco>((json) => Banco.fromMap(json)).toList() : List<Caja>();
      for(Banco c in lista){
        print("Nombre: ${c.descripcion}");
      }
     _streamController.add(lista);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de _init bancosscreen index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _store() async {
    // try {
      // setState(() => _cargando = true);
      _banco.descripcion = _txtDescripcion.text;
      _banco.estado = _ckbEstado;
      var parsed = await BankService.store(context: context, banco: _banco);
      print("_store: $parsed");
      _insertBancoTolistas(parsed);
     
      // setState(() => _cargando = false);
    // } catch (e) {
    //   print("errorrrrrrrr de guardar index: ${e.toString()}");
    //   setState(() => _cargando = false);
    // }
  }

  _create(){
    _banco = new Banco();
    _txtDescripcion.text = '';
    _ckbEstado = false;
     _showDialogFormulario();
  }
   
   _update(Banco banco){
     _banco = banco;
     _txtDescripcion.text = _banco.descripcion;
     _ckbEstado = _banco.estado;
     _showDialogFormulario();
   }

   _delete(Banco banco) async {
    try {
      
      var parsed = await BankService.delete(context: context, banco: banco);
      print("_delete: $parsed");
      _deleteBancoFromlistas(parsed);
     _streamController.add(lista);
      
    } catch (e) {
      print("errorrrrrrrr de _delete index: ${e.toString()}");
      
    }
   }


  

  _insertBancoTolistas(Map<String, dynamic> parsed){
    if(parsed["banco"] != null){
        Banco banco = Banco.fromMap(parsed["banco"]);
        
        int index = lista.indexWhere((element) => element.id == banco.id);
        if(index == -1){
          print("_insertBancoTolistas: ${banco.toJson()}");
          lista.add(banco);
          _streamController.add(lista);
        }else{
          print("_insertBancoTolistas2: ${banco.toJson()}");
          lista[index].descripcion = banco.descripcion;
          _streamController.add(lista);
        }
      }
  }

  _deleteBancoFromlistas(Map<String, dynamic> parsed){
    if(parsed["banco"] != null){
        Banco banco = Banco.fromMap(parsed["banco"]);
        Banco bancoAEliminar = lista.firstWhere((element) => element.id == banco.id);
        if(bancoAEliminar != null)
          lista.remove(bancoAEliminar);
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
            
            _ckbEstadoChanged(bool data){
              setState(() => _ckbEstado = data);
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
                    MyCheckBox(title: "Estado", value: _ckbEstado, onChanged: _ckbEstadoChanged, padding: 0,  medium: 2,),
                    
                    Wrap(
                      children: [
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

  _showDialogConfirmarEliminacion(Banco banco){
     showDialog(context: context, builder: (context){
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eliminar Banco"),
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
             content: Text("Seguro desea eliminar la ruta ${banco.descripcion}?"),
             actions: [
               FlatButton(onPressed: _back, child: Text("Cancelar")),
               FlatButton(onPressed: () async {
                //  try {
                   setState(() => _cargando = true);
                    await _delete(banco);
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
      bancos: true,
      body: [
        MyHeader(title: "Bancos", subtitle: "Administre todos sus bancos", function: _create, actionFuncion: "Agregar",),
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
                                      subtitle: Text("${(lista[index].estado) ? 'activo' : 'desactivado'}"),
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