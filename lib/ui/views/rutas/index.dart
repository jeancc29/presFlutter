import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/estado.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/ruta.dart';
import 'package:prestamo/core/models/trabajo.dart';
import 'package:prestamo/core/services/customerservice.dart';
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
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RutasScreen extends StatefulWidget {
  @override
  _RutasScreenState createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> with TickerProviderStateMixin {
  AppDatabase db;
  bool _cargando = false;
  var _txtDescripcion = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  StreamController<List<Ruta>> _streamControllerRutas;
  List<Ruta> listaRuta;
  Ruta _ruta = new Ruta();
  // var _controller = TabController(initialIndex: 0)
  
  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await RouteService.index(context: context, db: db);
      print("_init: $parsed");
      listaRuta = (parsed["rutas"] != null) ? parsed["rutas"].map<Ruta>((json) => Ruta.fromMap(json)).toList() : List<Ruta>();
      // for(Cliente c in listaCliente){
      //   print("Nombre: ${c.nombres}");
      //   print("documento: ${c.documento.toJson()}");
      // }
     _streamControllerRutas.add(listaRuta);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de cusomerservice index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _store() async {
    // try {
      // setState(() => _cargando = true);
      _ruta.descripcion = _txtDescripcion.text;
      var parsed = await RouteService.store(context: context, ruta: _ruta, db: db);
      print("_store: $parsed");
      _insertRutaToListaRutas(parsed);
     
      // setState(() => _cargando = false);
    // } catch (e) {
    //   print("errorrrrrrrr de guardar index: ${e.toString()}");
    //   setState(() => _cargando = false);
    // }
  }

  

  _insertRutaToListaRutas(Map<String, dynamic> parsed){
    if(parsed["ruta"] != null){
        Ruta ruta = Ruta.fromMap(parsed["ruta"]);
        
        int index = listaRuta.indexWhere((element) => element.id == ruta.id);
        if(index == -1){
          print("_insertRutaToListaRutas: ${ruta.toJson()}");
          listaRuta.add(ruta);
          _streamControllerRutas.add(listaRuta);
        }else{
          print("_insertRutaToListaRutas2: ${ruta.toJson()}");
          listaRuta[index].descripcion = ruta.descripcion;
          _streamControllerRutas.add(listaRuta);
        }
      }
  }

  _deleteRutaFromListaRutas(Map<String, dynamic> parsed){
    if(parsed["ruta"] != null){
        Ruta ruta = Ruta.fromMap(parsed["ruta"]);
        Ruta rutaAEliminar = listaRuta.firstWhere((element) => element.id == ruta.id);
        if(rutaAEliminar != null)
          listaRuta.remove(rutaAEliminar);
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
            return AlertDialog(
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Guardar ruta"),
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
                child: TextFormField(
                controller: _txtDescripcion,
                decoration: InputDecoration(labelText: "Descripcion *"),
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

  Widget _buildDataTable(List<Ruta> clientes){
    return SingleChildScrollView(

        child: DataTable(
          showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text("#", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Ruta", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Eliminar", style: TextStyle(fontWeight: FontWeight.w700),)), 
        ], 
        rows: clientes.map((e) => 
          DataRow(
            onSelectChanged: (selected){
              _update(e);
            },
          cells: [
            DataCell(Text(e.id.toString())
            ), 
            DataCell(Text(e.descripcion)
            ), 
            DataCell(
              IconButton(icon: Icon(Icons.delete), onPressed: (){_showDialogConfirmarEliminacion(e);})
            )
          ]
        )
        ).toList()
      ),
    );
  }

  _create(){
    _ruta = new Ruta();
    _txtDescripcion.text = '';
     _showDialogFormulario();
  }
   
   _update(Ruta ruta){
     _ruta = ruta;
     _txtDescripcion.text = _ruta.descripcion;
     _showDialogFormulario();
   }

   _delete(Ruta ruta) async {
    try {
      
      var parsed = await RouteService.delete(context: context, ruta: ruta, db: db);
      print("_delete: $parsed");
      _deleteRutaFromListaRutas(parsed);
     _streamControllerRutas.add(listaRuta);
      
    } catch (e) {
      print("errorrrrrrrr de _delete index: ${e.toString()}");
      
    }
   }

   _back(){
     Navigator.pop(context);
   }

   _showDialogConfirmarEliminacion(Ruta ruta){
     showDialog(context: context, builder: (context){
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eliminar ruta"),
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
             content: Text("Seguro desea eliminar la ruta ${ruta.descripcion}?"),
             actions: [
               FlatButton(onPressed: _back, child: Text("Cancelar")),
               FlatButton(onPressed: () async {
                //  try {
                   setState(() => _cargando = true);
                    await _delete(ruta);
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
    _streamControllerRutas = BehaviorSubject();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    db = Provider.of<AppDatabase>(context);
    _init();
    super.didChangeDependencies();
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
        
        MyWebDrawer(rutas: true,),
        SizedBox(width: 40), 
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Column(
                children: [
                  MyHeader(title: "Rutas", actionFuncion: "Crear ruta", function: _create),
                ],
              ),
             
             
              Expanded(
                child: StreamBuilder<List<Ruta>>(
                  stream: _streamControllerRutas.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data.length > 0){
                        return ListView(children: [
                          
                          _buildDataTable(snapshot.data)
                          
                        ],);
                      }else{
                        return Center(child: Text("No hay rutas", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
                      }
                    }

                    return Center(child: Text("No hay rutas", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
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

