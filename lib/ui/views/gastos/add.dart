import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/estado.dart';
import 'package:prestamo/core/models/gasto.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/models/trabajo.dart';
import 'package:prestamo/core/services/customerservice.dart';
import 'package:prestamo/core/services/expenseservice.dart';
import 'package:prestamo/core/services/routeservice.dart';
import 'package:prestamo/ui/views/clientes/add.dart';
import 'package:prestamo/ui/views/clientes/dialogreferencia.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/myappbar.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myexpansiontile.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:prestamo/ui/widgets/mywebdrawer.dart';
import 'package:rxdart/rxdart.dart';

class AddGastos extends StatefulWidget {
final Gasto data;

  AddGastos({Key key, this.data}) : super(key: key);

  @override
  _AddGastosState createState() => _AddGastosState();
}

class _AddGastosState extends State<AddGastos> with TickerProviderStateMixin {
  bool _cargando = false;
  var _txtConcepto = TextEditingController();
  var _fecha = DateTime.now();
  var _txtMonto = TextEditingController();
  var _txtComentario = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  StreamController<bool> _streamControllerCargo;
  List<Gasto> listaGasto;
  List<Tipo> listaTipo;
  List<Caja> listaCaja;
  Gasto _gasto = new Gasto();
  int _indexTipo = 0;
  int _indexCaja = 0;
  String _initialValueTipo;
  String _initialValueCaja;
  // var _controller = TabController(initialIndex: 0)
  
  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await ExpenseService.index(context: context);
      print("_init: ${parsed["cajas"]}");
      listaGasto = (parsed["gastos"] != null) ? parsed["gastos"].map<Gasto>((json) => Gasto.fromMap(json)).toList() : List<Gasto>();
      listaTipo = (parsed["tipos"] != null) ? parsed["tipos"].map<Tipo>((json) => Tipo.fromMap(json)).toList() : List<Tipo>();
      listaCaja = (parsed["cajas"] != null) ? parsed["cajas"].map<Caja>((json) => Caja.fromMap(json)).toList() : List<Caja>();
      // for(Cliente c in listaCliente){
      //   print("Nombre: ${c.nombres}");
      //   print("documento: ${c.documento.toJson()}");
      // }
     _streamControllerCargo.add(true);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de expenseService index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _store() async {
    try {
      setState(() => _cargando = true);
      
      _gasto.fecha = _fecha;
      _gasto.concepto = _txtConcepto.text;
      _gasto.comentario = _txtComentario.text;
      _gasto.monto = Utils.toDouble(_txtMonto.text);
      _gasto.tipo = listaTipo[_indexTipo];
      _gasto.caja = listaCaja[_indexCaja];
      _gasto.idCaja = _gasto.caja.id;
      _gasto.idTipo = _gasto.tipo.id;
      _gasto.idUsuario = 1;
      
      
      var parsed = await ExpenseService.store(context: context, gasto: _gasto);
      print("_store: $parsed");
      _sendSavedGastoBack(parsed);
     
      // setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de guardar index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  

  _sendSavedGastoBack(Map<String, dynamic> parsed){
    if(parsed["data"] != null){
        Gasto gasto = Gasto.fromMap(parsed["data"]);
        Navigator.pop(context, gasto);
      }
  }

 

  _closeDialog(){
    Navigator.pop(context);
  }


  
  Widget _buildDataTable(List<Gasto> clientes){
    return SingleChildScrollView(

        child: DataTable(
          
        columns: [
          DataColumn(label: Text("#", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Fecha", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Monto", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Concepto", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Categoria", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Caja", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Eliminar", style: TextStyle(fontWeight: FontWeight.w700),)), 
        ], 
        rows: clientes.map((e) => 
          DataRow(
            onSelectChanged: (selected){

            },
          cells: [
            DataCell(
              Text(e.fecha.toString())
            ), 
            DataCell(Text(e.monto.toString())), 
            DataCell(Text(e.concepto)), 
            DataCell(Text(e.tipo.descripcion)), 
            DataCell(Text(e.caja.descripcion)), 
            DataCell(
              IconButton(icon: Icon(Icons.delete), onPressed: (){
                // _showDialogConfirmarEliminacion(e);
              })
            )
          ]
        )
        ).toList()
      ),
    );
  }

  _create(){
    print("_create: ${widget.data}");
    _gasto = new Gasto();
    _txtConcepto.text = '';
    _txtComentario.text = '';
    _txtMonto.text = '';
    _fecha = DateTime.now();
  }
   
   _update(Gasto gasto){
     _gasto = gasto;
     _txtConcepto.text = _gasto.concepto;
     _txtComentario.text = _gasto.comentario;
     _txtMonto.text = _gasto.monto.toString();
     _fecha = _gasto.fecha;
     _initialValueTipo = _gasto.tipo.descripcion;
     _initialValueCaja = _gasto.caja.descripcion;
     print("_update: ${_gasto.toJson()}");
   }

  


   
  @override
  void initState() {
    // TODO: implement initState
    _streamControllerCargo = BehaviorSubject();
    if(widget.data == null)
        _create();
      else
        _update(widget.data);

    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer( child: ListView(children: [
      //   ListTile(
      //     leading: Icon(Icons.home),
      //     title: Text("Inicio"),
      //   )
      // ],),),
      appBar: myAppBar(context: context, cargando: _cargando),
      body: Row(children: [
        
        MyWebDrawer(gastos: true,),
        SizedBox(width: 40), 
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Column(
                children: [
                  MyHeader(title: "Gastos", actionFuncion: "Guardar", function: _store),
                ],
              ),
             
             StreamBuilder<bool>(
               stream: _streamControllerCargo.stream,
               builder: (context, snapshot) {
                if(snapshot.hasData){
                   return Padding(
                     padding: const EdgeInsets.all(50.0),
                     child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            MyDatePicker(
                              title: "Fecha *",
                              fecha: _fecha,
                              onDateTimeChanged: (data){
                                _fecha = data;
                              },
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                            MyDropdownButton(
                              initialValue: (_initialValueTipo != null) ? _initialValueTipo : null,
                              title: "Categoria",
                              elements: listaTipo.map((e) => e.descripcion).toList(),
                              onChanged: (data){
                                int idx = listaTipo.indexWhere((element) => element.descripcion == data);
                                if(idx != -1)
                                  setState(() => _indexTipo = idx);
                              },
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                            MyTextFormField(
                              title: "Concepto *",
                              controller: _txtConcepto,
                              isRequired: true,
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                            MyTextFormField(
                              title: "Monto *",
                              controller: _txtMonto,
                              isRequired: true,
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                            MyDropdownButton(
                              initialValue: (_initialValueCaja != null) ? _initialValueCaja : null,
                              title: "Caja",
                              elements: listaCaja.map((e) => e.descripcion).toList(),
                              onChanged: (data){
                                int idx = listaCaja.indexWhere((element) => element.descripcion == data);
                                if(idx != -1)
                                  setState(() => _indexCaja = idx);
                              },
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                            MyTextFormField(
                              title: "Comentario",
                              controller: _txtComentario,
                              xlarge: 2,
                              large: 2,
                              medium: 2,
                              small: 1,
                            ),
                          ],
                        ),
                      )),
                   );
                }

                return Center(child: Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: Text("Cargando..."),
                ));
               }
             )
              
              
            ],
          ),
        ),
        
      ],),
    );
  }

  

  

  
}

