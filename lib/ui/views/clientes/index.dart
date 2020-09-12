import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
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
import 'package:prestamo/core/models/trabajo.dart';
import 'package:prestamo/core/services/customerservice.dart';
import 'package:prestamo/ui/views/clientes/add.dart';
import 'package:prestamo/ui/views/clientes/dialogreferencia.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myexpansiontile.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:prestamo/ui/widgets/mywebdrawer.dart';
import 'package:rxdart/rxdart.dart';

class ClientesScreen extends StatefulWidget {
  @override
  _ClientesScreenState createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> with TickerProviderStateMixin {
  bool _cargando = false;
  bool _verTablaOContainers = false;
  StreamController<List<Cliente>> _streamControllerClientes;
  StreamController<List<Estado>> _streamControllerEstados;
  StreamController<List<Ciudad>> _streamControllerCiudadesTrabajo;
  StreamController<List<Estado>> _streamControllerEstadosTrabajo;
  StreamController<List<Ciudad>> _streamControllerCiudadesNegocio;
  StreamController<List<Estado>> _streamControllerEstadosNegocio;
  List<Cliente> listaCliente;
  // var _controller = TabController(initialIndex: 0)
  
  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await CustomerService.index(context: context);
      listaCliente = (parsed["clientes"] != null) ? parsed["clientes"].map<Cliente>((json) => Cliente.fromMap(json)).toList() : List<Cliente>();
      // for(Cliente c in listaCliente){
      //   print("Nombre: ${c.nombres}");
      //   print("documento: ${c.documento.toJson()}");
      // }
     _streamControllerClientes.add(listaCliente);
      setState(() => _cargando = false);
    } catch (e) {
      print("errorrrrrrrr de cusomerservice index: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  


    

   

  @override
  void initState() {
    // TODO: implement initState
    _streamControllerClientes = BehaviorSubject();
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
      appBar: AppBar(
        title: Row(children: [
          IconButton(icon: Icon(Icons.menu, color: Colors.black), onPressed: (){},),
          Text("Prestamo", style: TextStyle(color: Colors.black),),
          Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 60,
                  height: 60,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        widthFactor: 0.75,
                        heightFactor: 0.75,
                        child: Image(image: AssetImage('images/p7.jpeg'), ),
                      ),
                    ),
                  ),
                ),
              ),
        ],),
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.black
        // ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.info_outline, color: Colors.black,),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.help_outline, color: Colors.black,),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none, color: Colors.black,),
          ),
        ],
      ),
      body: Row(children: [
        
        MyWebDrawer(clientes: true,),
        SizedBox(width: 40), 
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Column(
                children: [
                  MyHeader(title: "Clientes", actionFuncion: "Crear cliente", function: (){Navigator.push(context, MaterialPageRoute(builder: (_) => ClientesAdd()));},),
                  
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(child: Icon(Icons.view_stream, color: _verTablaOContainers ? Utils.colorPrimary : Colors.grey.shade400), onTap: (){ setState(() => _verTablaOContainers = true);},),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(child: Icon(Icons.view_module, color: !_verTablaOContainers ? Utils.colorPrimary : Colors.grey.shade400), onTap: (){setState(() => _verTablaOContainers = false);},),
                    ),
                  ],),
                ],
              ),
             
             
              Expanded(
                child: StreamBuilder<List<Cliente>>(
                  stream: _streamControllerClientes.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data.length > 0){
                        return ListView(children: [
                          _verTablaOContainers
                          ?
                          _buildDataTable(snapshot.data)
                          :
                          Wrap(
                            // spacing: 20,
                            
                            children: snapshot.data.map((e) => _buildContainer(e)).toList(),
                          ),
                          
                        ],);
                      }else{
                        return Center(child: Text("No hay clientes", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
                      }
                    }

                    return Center(child: Text("No hay clientes", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700 )));
                  }
                )
              ),
            ],
          ),
        ),
        
      ],),
    );
  }

  Widget _buildContainer(Cliente cliente){
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("${cliente.nombres} ${cliente.apellidos}", style: TextStyle(fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.w700)),
                Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                    onTap: (){},
                    child: Text("Editar", style: TextStyle(fontSize: 17, color: Utils.colorPrimary, fontWeight: FontWeight.w700),),
                ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){},
                    child: Text("Borrar", style: TextStyle(fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w700),),
                  ),
                ),
                ],)
              ],),
              SizedBox(height: 20,),
              Row(
                children: [
                  Utils.getClienteFoto(cliente, size: 75),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cedula", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade500),),
                        Text("${cliente.documento.descripcion}", style: TextStyle(fontSize: 17),),
                        Text("Celular", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade500),),
                        Text("${cliente.contacto.celular}", style: TextStyle(fontSize: 17)),
                        
                        // Text("36,000", style: TextStyle(color: Utils.colorPrimary, fontWeight: FontWeight.w700,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Capital", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade500),),
                        Text("0 RD\$", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),),
                        Text("Balance", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade500),),
                        Text("0 RD\$", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,)),
                        
                        // Text("36,000", style: TextStyle(color: Utils.colorPrimary, fontWeight: FontWeight.w700,)),
                      ],
                    ),
                  )
                ],
              ),
              //  ListTile(
              //   isThreeLine: true,
              //   leading: Utils.getClienteFoto(Cliente()),
              //   title: Text("Jean"),
              //   subtitle: Text("Balance: 0"),
              // )
            ],
          ),
        ),
    ),
     );
  }

  Widget _buildDataTable(List<Cliente> clientes){
    return SingleChildScrollView(
        child: DataTable(
        columns: [
          DataColumn(label: Text("Nombres", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Celular", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Telefono", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Ingresos", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Capital pendiente", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Balance pendiente", style: TextStyle(fontWeight: FontWeight.w700),)),
        ], 
        rows: clientes.map((e) => 
          DataRow(
          cells: [
            DataCell(Row(children: [Utils.getClienteFoto(e, size: 40, radius: 20), Padding(padding: EdgeInsets.only(left: 10), child: Text(e.nombres),),],)), 
            DataCell(Text(e.contacto.celular)), 
            DataCell(Text(e.contacto.telefono)), 
            DataCell(Text("${e.trabajo.ingresos}")), 
            DataCell(Text("RD\$0")),
            DataCell(Text("RD\$0")),
          ]
        )
        ).toList()
      ),
    );
  }

  Widget _buildTable(List<Referencia> map){
   var tam = (map != null) ? map.length : 0;
   List<TableRow> rows;
   if(tam == 0){
     rows = <TableRow>[];
   }else{
     rows = map.asMap().map((idx, b)
          => MapEntry(
            idx,
            TableRow(
              
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: Utils.colorGreyFromPairIndex(idx: idx),
                  child: Center(
                    child: InkWell(onTap: (){}, child: Text(b.tipo, style: TextStyle(fontSize: 14, decoration: TextDecoration.underline)))
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: Utils.colorGreyFromPairIndex(idx: idx), 
                  child: Center(child: Text(b.nombre, style: TextStyle(fontSize: 14)))
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: Utils.colorGreyFromPairIndex(idx: idx), 
                  child: Center(child: Text(b.telefono, style: TextStyle(fontSize: 14)))
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: Utils.colorGreyFromPairIndex(idx: idx), 
                  child: Center(child: Text(b.parentesco, style: TextStyle(fontSize: 14)))
                ),
                
                // Container(
                //   padding: EdgeInsets.only(top: 5, bottom: 5),
                //   color: (Utils.toDouble(b["balanceActual"].toString()) >= 0) ? Utils.colorInfoClaro : Utils.colorRosa, 
                //   child: Center(child: Text("${Utils.toCurrency(b["balanceActual"])}", style: TextStyle(fontSize: 14)))
                // ),
                // Center(child: IconButton(icon: Icon(Icons.delete, size: 28,), onPressed: () async {_removerReferencia(b);},)),
              ],
            )
          )
        
        ).values.toList();
   }

   rows.insert(0, 
              TableRow(
                decoration: BoxDecoration( border: Border(bottom: BorderSide())),
                children: [
                  // buildContainer(Colors.blue, 50.0),
                  // buildContainer(Colors.red, 50.0),
                  // buildContainer(Colors.blue, 50.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
                    child: Center(child: Text('Tipo', style: TextStyle( fontWeight: FontWeight.bold)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
                    child: Center(child: Text('Nombre', style: TextStyle( fontWeight: FontWeight.bold, )),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
                    child: Center(child: Text('Telefono', style: TextStyle( fontWeight: FontWeight.bold)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
                    child: Center(child: Text('Parentesco', style: TextStyle( fontWeight: FontWeight.bold)),),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Borrar', style: TextStyle( fontWeight: FontWeight.bold)),),
                  ),
                ]
              )
              );

     

  return  Expanded(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: <int, TableColumnWidth>{
                  // 1 : FractionColumnWidth(.12),
                  7 : FractionColumnWidth(.28)
                  },
                children: rows,
               ),
          ),
        ],
      ),
  );
  
  
 }
}

