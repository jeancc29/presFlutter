import 'dart:async';
import 'dart:html';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/sucursal.dart';
import 'package:prestamo/core/services/branchofficeservice.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/mydropdown.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mySidetextformfield.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SucursalesScreen extends StatefulWidget {
  @override
  _SucursalesScreenState createState() => _SucursalesScreenState();
}

class _SucursalesScreenState extends State<SucursalesScreen> {
  AppDatabase db;
  var _txtSearch = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  StreamController<Widget> _streamControllerFoto;
  StreamController<List<Sucursal>> _streamController;
  var _txtNombre = TextEditingController();
  var _txtDireccion = TextEditingController();
  var _txtCiudad = TextEditingController();
  var _txtTelefono1 = TextEditingController();
  var _txtTelefono2 = TextEditingController();
  var _txtGerenteSucursal = TextEditingController();
  var _txtGerenteCobros = TextEditingController();
  List<Sucursal> listaSucursal = [];
  Sucursal _sucursal = Sucursal();
  bool _status = true;
  bool _cargando = false;

  _init() async {
    var parsed = await BranchofficeService.index(context: context, db: db);
     listaSucursal = parsed["sucursales"].map<Sucursal>((json) => Sucursal.fromMap(json)).toList();
    _streamController.add(listaSucursal);
    _streamControllerFoto.add(Utils.getSucursalFoto(_sucursal, size: 80, radius: 30));
  }
  

  _crear(){
    Navigator.pushNamed(context, "/sucursales/add");
  }

  _search(String data){
    print("SucursalesSCreen _search: $data");
    if(data.isEmpty)
      _streamController.add(listaSucursal);
    else
      {
        var element = listaSucursal.where((element) => element.nombre.toLowerCase().indexOf(data) != -1).toList();
        print("RolesScreen _serach length: ${element.length}");
        _streamController.add(listaSucursal.where((element) => element.nombre.toLowerCase().indexOf(data) != -1).toList());
      }
  }

   _addRolToList(Sucursal data){
    if(data != null){
      int idx = listaSucursal.indexWhere((element) => element.id == data.id);
      if(idx != -1)
        listaSucursal[idx] = data;
      else
        listaSucursal.add(data);

      _streamController.add(listaSucursal);
    }
  }

  _deleteRolFromList(Sucursal data){
    if(data != null){
      int idx = listaSucursal.indexWhere((element) => element.id == data.id);
      if(idx != -1){
       print("_deletedataFromList _showDialogEliminar: ${data.toJson()} idx: $idx");
        listaSucursal.removeAt(idx);
      _streamController.add(listaSucursal);
      }
    }
  }

  _showDialog({Sucursal sucursal}){
    bool cargando = false;
    if(sucursal == null)
      sucursal = Sucursal();

    _txtNombre.text = (sucursal.nombre != null) ? sucursal.nombre : '';
    _txtDireccion.text = (sucursal.direccion != null) ? sucursal.direccion : '';
    _txtCiudad.text = (sucursal.ciudad != null) ? sucursal.ciudad : '';
    _txtTelefono1.text = (sucursal.telefono1 != null) ? sucursal.telefono1 : '';
    _txtTelefono2.text = (sucursal.telefono2 != null) ? sucursal.telefono2 : '';
    _txtGerenteSucursal.text = (sucursal.gerenteSucursal != null) ? sucursal.gerenteSucursal : '';
    _txtGerenteCobros.text = (sucursal.gerenteCobro != null) ? sucursal.gerenteCobro : '';
    _status = (sucursal.status != null) ? sucursal.status : true;

    _streamControllerFoto.add(Utils.getSucursalFoto(sucursal, size: 80, radius: 30));
    
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {

            _onStatusChanged(bool value){
              setState(() => _status = value);
            }

            _guardar() async {
              if(_formKey.currentState.validate() == false)
                return;

              sucursal.nombre = _txtNombre.text;
              sucursal.direccion = _txtDireccion.text;
              sucursal.ciudad = _txtCiudad.text;
              sucursal.telefono1 = _txtTelefono1.text;
              sucursal.telefono2 = _txtTelefono2.text;
              sucursal.gerenteSucursal = _txtGerenteSucursal.text;
              sucursal.gerenteCobro = _txtGerenteCobros.text;
              sucursal.status = _status;
              setState(() => cargando = true);
              var parsed = await BranchofficeService.store(context: context, sucursal: sucursal, db: db);
              setState(() => cargando = false);
              _addRolToList(Sucursal.fromMap(parsed["sucursal"]));
              Navigator.pop(context);
            }

            return MyAlertDialog(
              title: "Guardar", 
              description: "Las sucursales le permitiran separar sus puntos de ventas.",
              cargando: cargando,
              content: Form(
                key: _formKey,
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                onTap: () async {
                  File file = await FilePicker.getFile();
                  sucursal.foto = await Utils.blobfileToUint(file); 
                  _streamControllerFoto.add(Utils.getSucursalFoto(sucursal, size: 80, radius: 30));
                  
                  // _futureFoto = Utils.getClienteFoto(_cliente);
                  // _streamControllerFotoCliente.add(file);
                  // IO.File(file.relativePath);
                  // // base64.decode(file);
                  // setState(() {
                  //   _image = file;
                  // });
                  // _startFilePicker();
                  // print("Archivo: ${file.name}");
                  // Blo
                  // print("ArchivoType: ${file.}");
                },
                child: 
                StreamBuilder<Widget>(
                  stream: _streamControllerFoto.stream,
                  builder: (context, snapshot) {
                        if(snapshot.hasData)
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: snapshot.data,
                          );
                        
                        return SizedBox();
                  }
                )
                // StreamBuilder<File>(
                //   stream: _streamControllerFotoCliente.stream,
                //   builder: (context, snapshot) {
                //     if(snapshot.hasData)
                //       _cliente.foto = snapshot.data; 
                //     return Container(
                //       // color: ,
                //       width: 130,
                //       height: 130,
                //       child:  ClipRRect(
                //         borderRadius: BorderRadius.circular(10),
                //         child: Container(
                //           child: Utils.getClienteFoto(_cliente),
                //         ),
                //       ),
                //     );
                //   }
                // ),
              ),
                      
                      ],
                    ),
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtNombre,
                        title: "Nombre sucursal",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtDireccion,
                        title: "Direccion",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtCiudad,
                        title: "Ciudad",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtTelefono1,
                        title: "Telefono1",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtTelefono2,
                        title: "Telefono2",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtGerenteSucursal,
                        title: "Gerente sucursal",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MySideTextFormField(
                        controller: _txtGerenteCobros,
                        title: "Gerente Cobros",
                        enabled: true,
                        large: 1,
                        medium: 1.3,
                        
                      ),
                    ),
                    // MyCheckBox(title: "Activa", value: _status, onChanged: _onStatusChanged,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MyResizedContainer(
                        medium: 2.8,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: Text("Activo", style: TextStyle(fontFamily: "GoogleSans",),),
                              ),
                              Switch(
                                onChanged: _onStatusChanged,
                                value: _status,
                              )
                            ],
                          ),
                      ),
                    )
                  ],
                ),
              ), 
              okFunction: _guardar
            );
          }
        );
      }
    );
  }

  _showDialogEliminar({@required Sucursal sucursal}){
    bool cargando = false;
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {
            return MyAlertDialog(
              title: "Eliminar", 
              cargando: cargando,
              isDeleteDialog: true,
              content: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: "GoogleSans"),
                  children: [
                    TextSpan(text: "Seguro que desea eliminar la sucursal "),
                    TextSpan(text: "${sucursal.nombre}?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                  ]
                )
              ), 
              okFunction: () async {
                setState(() => cargando = true);
                var parsed = await BranchofficeService.delete(context: context, sucursal: sucursal, db: db);
                setState(() => cargando = false);
                _deleteRolFromList(Sucursal.fromMap(parsed["sucursal"]));
                Navigator.pop(context);
              }
            );
          }
        );
      }
    );
  }

  _getPhoto(String namePhoto, {size: 40, radius: 20}){
    return Container(
          // color: Colors.blue,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              // color: Colors.blue,
              child: FadeInImage(
                image: NetworkImage(
                    '${Utils.URL}/assets/perfil/$namePhoto'),
                placeholder: AssetImage('images/user.png'),
              )
            ),
          ),
        );
    
  }

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _streamControllerFoto = BehaviorSubject();
    super.initState();
  }

  _filtroChanged(dynamic data){
    if(data == "Activa")
      _streamController.add(listaSucursal.where((element) => element.status).toList());
    else if(data == "Desactivada")
      _streamController.add(listaSucursal.where((element) => element.status == false).toList());
    else
      _streamController.add(listaSucursal);
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
    return myScaffold(
      context: context,
      cargando: _cargando,
      sucursales: true,
      body: [
        MyHeader(title: "Sucursales", subtitle: "Crea, edita y elimina sucursales para que tengas un control de todos sus puntos de ventas.", function: _showDialog, actionFuncion: "Crear",),
        Expanded(
          child: StreamBuilder<List<Sucursal>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData == false)
                return Center(child: CircularProgressIndicator(),);

              return MyScrollbar(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: MySubtitle(title: "${snapshot.data.length} Sucursales", fontSize: 20, fontWeight: FontWeight.w500,),
                    ),

                    Stack(
                      children: [
                        MyDropdown(
                          title: "Filtrar por",
                          elements: [["Activa", "Activa"], ["Desactivada", "Desactivada"], ["Todas", "Todas"]], 
                          hint: "Todas",
                          xlarge: 6.0,
                          leading: false,
                          onTap: _filtroChanged,
                        ),
                        Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 18.0),
                          child: MySearchField(controller: _txtSearch, onChanged: _search, hint: "Buscar por nombre...", xlarge: 3.0,),
                        ))
                      ],
                    ),
                    MyTable(
                      isScrolled: false,
                      columns: ["#", "Nombre", "Ciudad", "Telefono 1", "Activa"], 
                      rows: snapshot.data.asMap().map((key, value) => MapEntry(
                        key, 
                        [
                          value,
                          "${key + 1}", 
                          Row(
                            children: [
                              _getPhoto(value.nombreFoto), 
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text("${value.nombre}"),
                              )
                            ]
                          ),
                          "${value.ciudad}",
                          "${value.telefono1}",
                          "${(value.status) ? 'Si' : 'No'}",
                        ]
                      )).values.toList(),
                      onTap: (data){
                        _showDialog(sucursal: data);
                      },
                      delete: (data){
                        _showDialogEliminar(sucursal: data);
                      },
                    )
                  ],
                ),
              );
            }
          ),
        
        )
      ]
    );
  }
}