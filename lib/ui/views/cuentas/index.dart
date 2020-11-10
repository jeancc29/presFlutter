import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/services/accountservice.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysidedropdownbutton.dart';
import 'package:prestamo/ui/widgets/mysidetextformfield.dart';
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
  List<Banco> listaBanco = List();
  Cuenta _cuenta = Cuenta();
  Banco _banco = Banco();
  String _initialValueBanco;

  _showDialog(){
    showDialog(
      context: context,
      builder: (context){
        return LayoutBuilder(
          builder: (context, boxconstraints){
            return AlertDialog(
              title: Text("Soy la pruba"),
              content: Container(width: (boxconstraints.maxWidth != 0) ? boxconstraints.maxWidth / 2 : MediaQuery.of(context).size.width,child: Text("Soy la segundaPrueba"))
            );
          },
        );
      }
    );
  }

  _init() async {
    try {
     var parsed = await AccountService.index(context: context);
     listaCuenta = parsed["cuentas"].map<Cuenta>((json) => Cuenta.fromMap(json)).toList();
     listaBanco = parsed["bancos"].map<Banco>((json) => Banco.fromMap(json)).toList();
    if(listaBanco.length > 0)
      _banco = listaBanco[0];

      print("CuentasScreen _init error: ${parsed}");
    
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

  _store() async {
      _cuenta.banco = _banco;
      _cuenta.idBanco = _banco.id;
      _cuenta.descripcion = _txtDescripcion.text;
      var parsed = await AccountService.store(context: context, cuenta: _cuenta);
      _addElementToList(Cuenta.fromMap(parsed["cuenta"]));
  }

  _addElementToList(Cuenta cuenta){
    if(cuenta == null)
      return;
    
    int idx = listaCuenta.indexWhere((element) => element.id == cuenta.id);
    if(idx != -1)
      listaCuenta[idx] = cuenta;
    else
      listaCuenta.add(cuenta);

    _streamController.add(listaCuenta);
  }

  _create(){
    _cuenta = Cuenta();
    _txtDescripcion.text = "";
    _initialValueBanco = null;
    if(listaBanco.length > 0)
      _banco = listaBanco[0];
      
    _showDialogFormulario();
  }

  _update(Cuenta cuenta){
    _cuenta = cuenta;
    _txtDescripcion.text = _cuenta.descripcion;
    int idx = listaBanco.indexWhere((element) => element.id == _cuenta.banco.id);
    if(idx != -1){
      _initialValueBanco = listaBanco[idx].descripcion;
      _banco = listaBanco[idx];
    }
    _showDialogFormulario();
  }

  _delete(Cuenta cuenta) async {
    bool acepta = await Utils.showDialogConfirmarEliminacion(context: context, title: "Eliminar cuenta", descripcion: "Seguro desea eliminar la cuenta ${cuenta.descripcion}");
    if(acepta){
      //Eliminar
    }
  }

  

  _showDialogFormulario(){
    print("Holaa");
    bool _cargando2 = false;
    // return;
    showDialog(
      context: context,
      builder: (context){
        _back({Cuenta cuenta}){
          Navigator.pop(context, cuenta);
        }
        return StatefulBuilder(
          builder: (context, setState) {
            return MyAlertDialog(
              cargando: _cargando,
              title: "Guardar cuenta", 
              description: "Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja",
              content: Wrap(
                children: [
                  MySideDropdownButton(
                    initialValue: (_initialValueBanco != null) ? _initialValueBanco : null,
                    medium: 1.3,
                    padding: 0,
                    title: "Banco *",
                    elements: listaBanco.map((banco) => banco.descripcion).toList(),
                    onChanged: (data){
                      int idx = listaBanco.indexWhere((element) => element.descripcion == data);
                      if(idx != -1)
                        _banco = listaBanco[idx];
                    },
                    // decoration: InputDecoration(labelText: "Descripcion *"),
                  ),
                  Form(
                    key: _formKey,
                    child: MySideTextFormField(
                      medium: 1.3,
                      padding: 0,
                      controller: _txtDescripcion,
                      title: "Descripcion *",
                      isRequired: true,
                      // decoration: InputDecoration(labelText: "Descripcion *"),
                    ),
                  ),
                ],
              ), 
              okFunction: () async {
                if(_formKey.currentState.validate()){
                  if(_banco == null)
                    return;

                   try {
                      setState(() => _cargando = true);
                      await _store();
                      setState(() => _cargando = false);
                      _back();
                    } catch (e) {
                      setState(() => _cargando = false);
                    }
                }
              }
            );
          }
        );
        
        // StatefulBuilder(
        //   builder: (context, setState) {
        //     return AlertDialog(
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        //       titlePadding: EdgeInsets.only(left: 24, right: 15, top: 10),
        //       contentPadding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        //       title:
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text("Guardar cuenta", style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
        //           Align(
        //             alignment: Alignment.topRight,
        //             child: IconButton(
        //               icon: Icon(Icons.clear),
        //               onPressed: _back,
        //             ),
        //           )
        //         ],
        //       )
        //       ,
        //       content: Container(
        //         // padding: EdgeInsets.only(bottom: 20),
        //         width: MediaQuery.of(context).size.width / 2.5,
        //         child: Form(
        //         key: _formKey,
        //         child: Wrap(
        //           children: [
                    
        //         //     Row(
        //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         // children: [
        //         //   // Text("Guardar cuenta", style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w600)),
                 
        //         //   Align(
        //         //     alignment: Alignment.topRight,
        //         //     child: IconButton(
        //         //       icon: Icon(Icons.clear),
        //         //       onPressed: _back,
        //         //     ),
        //         //   )
        //         // ],
        //         //     ),
        //             //  Padding(
        //             //   padding: const EdgeInsets.only(top: 3.0, bottom: 14),
        //             //   child: Text("Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.65),),),
        //             // ),
        //              Padding(
        //               padding: const EdgeInsets.only(top: 3.0, bottom: 14),
        //               child: Text("Las cuentas se usaran para hacer depositos, cheques, etc. El cual se reflejaran en la caja.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.65),),),
        //             ),
        //             MySideTextFormField(
        //               medium: 1.3,
        //               padding: 0,
        //               controller: _txtDescripcion,
        //               title: "Descripcion *",
        //               // decoration: InputDecoration(labelText: "Descripcion *"),
        //             ),
        //           ],
        //         ))
        //       ),
        //       actions: [
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 10.0),
        //         child: FlatButton(child: Text("Cancelar", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)), onPressed: _back),
        //       ),
        //     // FlatButton(child: Text("Agregar", style: TextStyle(color: Utils.colorPrimaryBlue)), onPressed: () => _retornarReferencia(referencia: Referencia(nombre: _txtNombre.text, telefono: _txtTelefono.text, tipo: _tipo, parentesco: _parentesco)),),
        //       Padding(
        //         padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        //         child: myButton(
        //           text: "Guardar",
        //           function: () async{
        //             if(_formKey.currentState.validate()){

        //             }
        //           }, 
        //         ),
        //       ),
            
        //       ],
        //     );
        //   }
        // );
      }
    );
  }


  Widget _buildDataTable(List<Cuenta> lista){
    return SingleChildScrollView(

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
    );
  }


  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: false,
      cuentas: true,
      body: [
        MyHeader(title: "Cuentas", function: _create, actionFuncion: "Agregar",),
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