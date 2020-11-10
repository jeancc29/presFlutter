import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/services/accountservice.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:rxdart/rxdart.dart';

class CuentasScreen extends StatefulWidget {
  @override
  _CuentasScreenState createState() => _CuentasScreenState();
}

class _CuentasScreenState extends State<CuentasScreen> {
  bool _cargando = false;
  var _formKey = GlobalKey<FormState>();
  StreamController<List<Cuenta>> _streamController;
  var _txtDescripcion = TextEditingController();
  List<Cuenta> listaCuenta = List();
  Cuenta _cuenta = Cuenta();

  _showDialog(){

  }

  _init() async {
    try {
     var parsed = await AccountService.index(context: context);
     listaCuenta = parsed["cuentas"].map<Cuenta>((json) => Cuenta.fromMap(json)).toList();
    _streamController.add(listaCuenta);
    } catch (e) {
      print("CuentasScreen _init error: ${e.toString()}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  _update(Cuenta cuenta){
    _cuenta = cuenta;
    _txtDescripcion.text = _cuenta.descripcion;
  }

  _delete(Cuenta cuenta) async {
    bool acepta = await Utils.showDialogConfirmarEliminacion(context: context, title: "Eliminar cuenta", descripcion: "Seguro desea eliminar la cuenta ${cuenta.descripcion}");
    if(acepta){
      //Eliminar
    }
  }

  _showDialogFormulario(){
    print("Holaa");
    // return;
    showDialog(
      context: context,
      builder: (context){
        _back({Cuenta cuenta}){
          Navigator.pop(context, cuenta);
        }
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                  
              // title:
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text("Guardar cuenta", style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
              //         Padding(
              //         padding: const EdgeInsets.only(top: 10.0),
              //         child: Text("Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja", style: TextStyle(fontSize: 14, color: Colors.black, letterSpacing: 0.4),),
              //       ),
              //       ],
              //     ),
              //     Align(
              //       alignment: Alignment.topRight,
              //       child: IconButton(
              //         icon: Icon(Icons.clear),
              //         onPressed: _back,
              //       ),
              //     )
              //   ],
              // )
              // ,
              content: Container(
                // padding: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width / 2.5,
                child: Form(
                key: _formKey,
                child: Wrap(
                  children: [
                    
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Guardar cuenta", style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
                 
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: _back,
                    ),
                  )
                ],
                    ),
                    //  Padding(
                    //   padding: const EdgeInsets.only(top: 3.0, bottom: 14),
                    //   child: Text("Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.65),),),
                    // ),
                     Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 14),
                      child: Text("Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.65),),),
                    ),
                    MyTextFormField(
                      medium: 1.3,
                      padding: 0,
                      controller: _txtDescripcion,
                      sideTitle: "Descripcion *",
                      // decoration: InputDecoration(labelText: "Descripcion *"),
                    ),
                  ],
                ))
              ),
              actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: _back),
              ),
            // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: myButton(
                  text: "Guardar",
                  function: () async{
                    if(_formKey.currentState.validate()){

                    }
                  }, 
                ),
              ),
            
              ],
            );
          }
        );
      }
    );
  }


  Widget _buildDataTable(List<Cuenta> lista){
    return SingleChildScrollView(

        child: Center(
          child: DataTable(
            showCheckboxColumn: false,
          columns: [
            DataColumn(label: Text("#", style: TextStyle(fontWeight: FontWeight.w700),)), 
            DataColumn(label: Text("Cuenta", style: TextStyle(fontWeight: FontWeight.w700),)), 
            DataColumn(label: Text("Banco", style: TextStyle(fontWeight: FontWeight.w700),)), 
            DataColumn(label: Text("Eliminar", style: TextStyle(fontWeight: FontWeight.w700),)), 
          ], 
          rows: lista.map((e) => 
            DataRow(
              onSelectChanged: (selected){
                _update(e);
              },
            cells: [
              DataCell(Text(e.id.toString())
              ), 
              DataCell(Text(e.descripcion)
              ), 
              DataCell(Text(e.banco.descripcion)
              ), 
              DataCell(
                IconButton(icon: Icon(Icons.delete), onPressed: (){_delete(e);})
              )
            ]
          )
          ).toList()
      ),
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      cuentas: true,
      body: [
        MyHeader(title: "Cuentas", function: _showDialogFormulario, actionFuncion: "Agregar",),
        Container(
          child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot){
              if(snapshot.hasData)
                return _buildDataTable(snapshot.data);
              
              return Center(
                child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Utils.colorPrimaryBlue),
                    child: new CircularProgressIndicator(),
                  ),
                ),
              ),
              );
            },
          ),
        )
      ]
    );
  }
}