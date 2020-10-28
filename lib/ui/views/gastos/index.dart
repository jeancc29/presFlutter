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

class GastosScreen extends StatefulWidget {
  @override
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> with TickerProviderStateMixin {
  bool _cargando = false;
  var _txtConcepto = TextEditingController();
  var _fecha = DateTime.now();
  var _txtMonto = TextEditingController();
  var _txtComentario = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  StreamController<List<Gasto>> _streamControllerGastos;
  List<Gasto> listaGasto;
  List<Tipo> listaTipo;
  List<Caja> listaCaja;
  Gasto _gasto = new Gasto();
  int _indexTipo = 0;
  int _indexCaja = 0;
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
     _streamControllerGastos.add(listaGasto);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de expenseService index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

 
  _insertGastoToListaGasto(Gasto gasto){
    if(gasto != null){
        int index = listaGasto.indexWhere((element) => element.id == gasto.id);
        if(index == -1){
          print("_insertGastoToListaGasto: ${gasto.toJson()}");
          listaGasto.add(gasto);
          _streamControllerGastos.add(listaGasto);
        }else{
          print("_insertgastoToListaGasto: ${gasto.toJson()}");
          listaGasto[index] = gasto;
          _streamControllerGastos.add(listaGasto);
        }
      }
  }

  _deleteGastoFromListaGasto(Map<String, dynamic> parsed){
    if(parsed["gasto"] != null){
        Gasto gasto = Gasto.fromMap(parsed["gasto"]);
        Gasto gastoAEliminar = listaGasto.firstWhere((element) => element.id == gasto.id);
        if(gastoAEliminar != null)
          listaGasto.remove(gastoAEliminar);
      }
  }

  _closeDialog(){
    Navigator.pop(context);
  }


  
  Widget _buildDataTable(List<Gasto> clientes){
    return SingleChildScrollView(

        child: DataTable(
          showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text("#"),), 
          DataColumn(label: Text("Fecha"),), 
          DataColumn(label: Text("Monto"),), 
          DataColumn(label: Text("Concepto"),), 
          DataColumn(label: Text("Categoria"),), 
          DataColumn(label: Text("Caja"),), 
          DataColumn(label: Text("Eliminar"),), 
        ], 
        rows: clientes.map((e) => 
          DataRow(
            onSelectChanged: (selected){
              Navigator.pushNamed(context, "/AddGastos", arguments: e);
            },
          cells: [
            DataCell(Text(e.id.toString())), 
            DataCell(Text(e.fecha.toString())), 
            DataCell(Text(e.monto.toString())), 
            DataCell(Text(e.concepto)), 
            DataCell(Text(e.tipo.descripcion)), 
            DataCell(Text(e.caja.descripcion)), 
            DataCell(
              IconButton(icon: Icon(Icons.delete), onPressed: (){
                _showDialogConfirmarEliminacion(e);
              })
            )
          ]
        )
        ).toList()
      ),
    );
  }

  

   _delete(Gasto gasto) async {
    try {
      
      var parsed = await ExpenseService.delete(context: context, gasto: gasto);
      print("_delete: $parsed");
      _deleteGastoFromListaGasto(parsed);
     _streamControllerGastos.add(listaGasto);
      
    } catch (e) {
      print("errorrrrrrrr de _delete index: ${e.toString()}");
      
    }
   }

   _back(){
     Navigator.pop(context);
   }

   _showDialogConfirmarEliminacion(Gasto gasto){
     showDialog(context: context, builder: (context){
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eliminar gasto"),
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
             content: Text("Seguro desea eliminar la gasto ${gasto.concepto}?"),
             actions: [
               FlatButton(onPressed: _back, child: Text("Cancelar")),
               FlatButton(onPressed: () async {
                //  try {
                   setState(() => _cargando = true);
                    await _delete(gasto);
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
    _streamControllerGastos = BehaviorSubject();
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
                  MyHeader(title: "Gastos", actionFuncion: "Crear gasto", function: () async {
                    // _insertGastoToListaGasto(await Navigator.pushNamed(context, "/AddGastos", arguments: null));
                    var gasto = await Navigator.pushNamed(context, "/AddGastos", arguments: null);
                    _insertGastoToListaGasto(gasto);
                    print("test: ${gasto}");
                  }),
                ],
              ),
             
             
              Expanded(
                child: StreamBuilder<List<Gasto>>(
                  stream: _streamControllerGastos.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data.length > 0){
                        return ListView(children: [
                          
                          _buildDataTable(snapshot.data)
                          
                        ],);
                      }else{
                        return Center(child: Text("No hay gastos", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
                      }
                    }

                    return Center(child: Text("No hay gastos", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
                  }
                )
              ),
            ],
          ),
        ),
        
      ],),
    );
  }

  

  

  
}

