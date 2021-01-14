import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/models/entidad.dart';
import 'package:prestamo/core/models/permiso.dart';
import 'package:prestamo/core/models/rol.dart';
import 'package:prestamo/core/services/roleservice.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytable.dart';
import 'package:rxdart/rxdart.dart';

class RolesScreen extends StatefulWidget {
  @override
  _RolesScreenState createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _txtSearch = TextEditingController();
  var _txtDescripcion = TextEditingController();
  bool _ckbExpansion = false;
  bool _cargando = false;
  StreamController<List<Rol>> _streamController;
  List<Rol> listaRol = [];
  List<Entidad> listaEntidad = [];

  _init() async {
    // try {
      // setState(() => _cargando = true);
      var parsed = await RoleService.index(context: context,);
      print("RolesScreen _init parsed: $parsed");
      listaRol = (parsed["roles"] != null) ? parsed["roles"].map<Rol>((json) => Rol.fromMap(json)).toList() : [];
      listaEntidad = (parsed["entidades"] != null) ? parsed["entidades"].map<Entidad>((json) => Entidad.fromMap(json)).toList() : [];

      _streamController.add(listaRol);
      setState(() => _cargando = false);
    // } on Exception catch (e) {
    //       // TODO
    //       print("Error RolesScreen _init: ${e.toString()}");
    // }
    
  }

  _search(String data){
    print("ROlesSCreen _search: $data");
    if(data.isEmpty)
      _streamController.add(listaRol);
    else
      {
        var element = listaRol.where((element) => element.descripcion.toLowerCase().indexOf(data) != -1).toList();
        print("RolesScreen _serach length: ${element.length}");
        _streamController.add(listaRol.where((element) => element.descripcion.toLowerCase().indexOf(data) != -1).toList());
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  _ckbPermisoChanged(bool value){

  }

  

 
  _showDialog({Rol rol}) async {

    bool cargando = false;

    listaEntidad.forEach((element) {
      element.permisos.forEach((e) {
        e.seleccionado = false;
      });
    });
    _txtDescripcion.text = "";

    if(rol != null){
      listaEntidad.forEach((element) {
        element.permisos.forEach((element2) {
          element2.seleccionado = (rol.permisos.indexWhere((permiso) => permiso.id == element2.id) != -1) ? true : false;
        });
      });
    _txtDescripcion.text = rol.descripcion;

    }

    List<Widget> listaWidget = [];

    return await showDialog(context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {

            Widget _myPermissionCheckbox(Permiso permiso){
              return MyCheckBox(
                medium: 3,
                title: "${permiso.descripcion}",
                value: permiso.seleccionado,
                onChanged: (bool value){
                  print("RolesScreen _myPermissionCheckbox: $value");                                 
                  setState(() => permiso.seleccionado = value);
                },
              );
            }

            Widget _myEntityCheckbox(Entidad entidad){
              return Checkbox(
                    onChanged: (data){ 
                      setState(() {
                      _ckbExpansion = data;
                    });
                    }, 
                  value: entidad.permisos.length == entidad.permisos.where((element) => element.seleccionado == true).toList().length
                );
            }

             ExpansionTile _permissionScreen(Entidad entidad){
              return ExpansionTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _myEntityCheckbox(entidad),
                ),
                title: Text("${entidad.descripcion}", style: TextStyle(fontFamily: "GoogleSans"),),
                children: [
                  Center(
                    child: MyResizedContainer(
                      // color: Colors.red,
                      medium: 1.2,
                      child: Wrap(
                        children: entidad.permisos.map((e) => _myPermissionCheckbox(e)).toList(),
                        // children: [
                        //   MyCheckBox(
                        //     medium: 3,
                        //     title: "Crear",
                        //     value: false,
                        //   ),
                        //   MyCheckBox(
                        //     medium: 3,
                        //     title: "Actualizar",
                        //     value: false,
                        //   ),
                        //   MyCheckBox(
                        //     medium: 3,
                        //     title: "Eliminar",
                        //     value: false,
                        //   ),
                        // ],
                      ),
                    ),
                  )
                ],
              );
                        
            }


            

            listaWidget = listaEntidad.map<Widget>((e) => _permissionScreen(e)).toList();
            listaWidget.insert(0, Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _txtDescripcion,
                    decoration: InputDecoration(
                      hintText: "Descripcion"
                    ),
                    validator: (data){
                      if(data.isEmpty)
                        return "Campo vacio";
                      return null;
                    },
                  ),
                ));

                _back({Rol rolToReturn}){
                  Navigator.pop(context, rolToReturn);
                }

                _guardar() async {
                  if(_formKey.currentState.validate()){
                    setState(() => cargando = true);
                    var rolToSave = Rol();
                    if(rol != null)
                      rolToSave.id = rol.id;
                    rolToSave.descripcion = _txtDescripcion.text;
                    rolToSave.permisos = [];
                    listaEntidad.forEach((element) {
                      element.permisos.forEach((element2) {
                        if(element2.seleccionado)
                          rolToSave.permisos.add(element2);
                      });
                    });
                    var parsed = await RoleService.store(context: context, rol: rolToSave);
                    setState(() => cargando = false);
                    _back(rolToReturn: Rol.fromMap(parsed["rol"]));
                  }
                }

            return MyAlertDialog(
              title: "Guardar", 
              content: Wrap(children: listaWidget),
              // Wrap(children: [
              //   LayoutBuilder(
              //     builder: (context, boxconstraint) {
              //       return Container(
              //         height: boxconstraint.maxHeight,
              //         color: Colors.red,
              //         child: Text("Hola")
              //         // MyScrollbar(
              //         //   child: Wrap(children: listaWidget,)
              //         // ),
              //       );
              //     }
              //   )
              // ],), 
              cargando: cargando,
              okFunction: () async {
                print("OkFunction");
                await _guardar();
              }
            );
          }
        );
      }
    );
  }

  _showDialogEliminar({Rol rol}) async {
    bool cargando = false;

    return await showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState){

            _back({Rol rolToReturn}){
              Navigator.pop(context, rolToReturn);
            }

            return MyAlertDialog(
              title: "Eliminar", 
              description: "Seguro desea eliminar el rol ${rol.descripcion}",
              content: null,
              cargando: cargando,
              isDeleteDialog: true,
              okFunction: () async {
                setState(() => cargando = true);
                var parsed = await RoleService.delete(context: context, rol: rol);
                setState(() => cargando = false);
                _back(rolToReturn: Rol.fromMap(parsed["rol"]));
              }
            );
          }
        );
      }
    );
  }

  _addRolToList(Rol rol){
    if(rol != null){
      int idx = listaRol.indexWhere((element) => element.id == rol.id);
      if(idx != -1)
        listaRol[idx] = rol;
      else
        listaRol.add(rol);

      _streamController.add(listaRol);
    }
  }
  _deleteRolFromList(Rol rol){
    if(rol != null){
      int idx = listaRol.indexWhere((element) => element.id == rol.id);
      if(idx != -1){
       print("_deleteRolFromList _showDialogEliminar: ${rol.toJson()} idx: $idx");
        listaRol.removeAt(idx);
      _streamController.add(listaRol);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: false,
      key: _scaffoldKey,
      roles: true,
      body: [
        MyHeader(title: "Roles", subtitle: "Crea los distintos tipos de roles y agregale sus permisos.", function: () async {
          var rol = await _showDialog();
          _addRolToList(rol);
        }, actionFuncion: "Crear",),
        Expanded(
          child: StreamBuilder<List<Rol>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData == false)
                return Center(child: CircularProgressIndicator());

              return MyScrollbar(
                child: Column(children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 18.0),
                          child: MySearchField(controller: _txtSearch, onChanged: _search, hint: "Buscar por cliente o codigo prestamo...", xlarge: 3.0,),
                      ))
                    ]
                  ),
                  MySubtitle(title: "Roles"),
                  MyTable(
                    columns: ["#", "Rol", "Permisos"], 
                    rows: snapshot.data.asMap().map((index, value) => MapEntry(index, [value, "${index + 1}", "${value.descripcion}", "${value.permisosString}"])).values.toList(),
                    onTap: (data) async {
                      
                      var rol = await _showDialog(rol: data);
                      _addRolToList(rol);
                    },
                    delete: (data) async {
                      var rol = await _showDialogEliminar(rol: data);
                     

                      _deleteRolFromList(rol);
                    },
                  )
                ],)
              );
            }
          ),
        )
      ]
    );
  }
}