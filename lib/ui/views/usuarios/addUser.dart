import 'dart:async';
import 'dart:html';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/entidad.dart';
import 'package:prestamo/core/models/permiso.dart';
import 'package:prestamo/core/models/rol.dart';
import 'package:prestamo/core/models/sucursal.dart';
import 'package:prestamo/core/models/usuario.dart';
import 'package:prestamo/core/services/userservice.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/mydropdown.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myempty.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/mymultiselect.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:prestamo/core/models/empresa.dart';
import 'package:prestamo/ui/widgets/mytable.dart';


class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  AppDatabase db;
  StreamController<List<Usuario>> _streamController;
  StreamController<Widget> _streamControllerFoto;
  TextEditingController _txtSearch = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtUsuario = TextEditingController();
  TextEditingController _txtNombres = TextEditingController();
  TextEditingController _txtApellidos = TextEditingController();
  TextEditingController _txtTelefono = TextEditingController();
  TextEditingController _txtCorreo = TextEditingController();
  List<Usuario> listaUsuario = [];
  List<Rol> listaRol = [];
  List<Caja> listaCaja = [];
  List<Sucursal> listaSucursal = [];
  List<Entidad> listaEntidad = [];
  List<Caja> _cajas = [];
  Rol _rol = Rol();
  Sucursal _sucursal = Sucursal();
  Usuario _usuario = Usuario();
  bool _cargando = false;

  

  _init() async {
    var parsed = await UserService.index(context: context, db: db);
    listaUsuario = (parsed["usuarios"] != null) ? parsed["usuarios"].map<Usuario>((e) => Usuario.fromMap(e)).toList() : [];
    listaRol = (parsed["roles"] != null) ? parsed["roles"].map<Rol>((e) => Rol.fromMap(e)).toList() : [];
    listaCaja = (parsed["cajas"] != null) ? parsed["cajas"].map<Caja>((e) => Caja.fromMap(e)).toList() : [];
    listaSucursal = (parsed["sucursales"] != null) ? parsed["sucursales"].map<Sucursal>((e) => Sucursal.fromMap(e)).toList() : [];
    listaEntidad = (parsed["entidades"] != null) ? parsed["entidades"].map<Entidad>((e) => Entidad.fromMap(e)).toList() : [];
    _selectFirstElementOfList();
    _streamControllerFoto.add(Utils.getWidgetUploadFoto(_usuario, radius: 30));
    _streamController.add(listaUsuario);
    // listaRol.forEach((element) {print("_init: ${element.toJson()}");});
  }

  _selectFirstElementOfList(){
    if(listaRol.length > 0)
      _rol = listaRol[0];
    if(listaSucursal.length > 0)
      _sucursal = listaSucursal[0];

    // _rol.permisos.forEach((element) {print("_selectFirstElementOfList: ${element.toJson()}");});
    
  }

  _addDataToList(Usuario usuario){
    if(usuario == null)
      return;

    print("_addDataToList: ${usuario.toJson()}");


    int idx = listaUsuario.indexWhere((element) => element.id == usuario.id);
    if(idx != -1)
      listaUsuario[idx] = usuario;
    else
      listaUsuario.add(usuario);

    print("_addDataToList: ${usuario.toJson()}");

    _streamController.add(listaUsuario);
  }

  _removeDataFromList(Usuario usuario){
    if(usuario == null)
      return;

    int idx = listaUsuario.indexWhere((element) => element.id == usuario.id);
    if(idx != -1)
      listaUsuario.removeAt(idx);

    _streamController.add(listaUsuario);
  }

  _search(String data){
    print("SucursalesSCreen _search: $data");
    if(data.isEmpty)
      _streamController.add(listaUsuario);
    else
      {
        var element = listaUsuario.where((element) => element.usuario.toLowerCase().indexOf(data) != -1).toList();
        print("RolesScreen _serach length: ${element.length}");
        _streamController.add(listaUsuario.where((element) => (element.usuario.toLowerCase().indexOf(data) != -1 || element.nombres.toLowerCase().indexOf(data) != -1 || element.apellidos.toLowerCase().indexOf(data) != -1)).toList());
      }
  }

  _filtroChanged(dynamic data){
    if(data == "Activa")
      _streamController.add(listaUsuario.where((element) => element.status == 1).toList());
    else if(data == "Desactivada")
      _streamController.add(listaUsuario.where((element) => element.status == 0).toList());
    else
      _streamController.add(listaUsuario);
  }

  _showDialogGuardar({Usuario usuario}){
    if(usuario == null)
      usuario = Usuario();
    
    print("_showDialogGuardar id: ${usuario.id}");
    List<Permiso> permisos = (usuario.permisos != null) ? (usuario.permisos.length > 0) ? usuario.permisos : null : null;
    _streamControllerFoto.add(Utils.getWidgetUploadFoto(usuario, radius: 30));
    _txtNombres.text = (usuario.nombres != null) ? usuario.nombres : '';
    _txtPassword.text = '';
    _txtApellidos.text = (usuario.apellidos != null) ? usuario.apellidos : '';
    _txtUsuario.text = (usuario.usuario != null) ? usuario.usuario : '';
    _txtTelefono.text = (usuario.contacto != null) ? (usuario.contacto.telefono != null) ? usuario.contacto.telefono : '' : '';
    _txtCorreo.text = (usuario.contacto != null) ? (usuario.contacto.correo != null) ? usuario.contacto.correo : '' : '';
    _cajas = (usuario.cajas != null) ? (usuario.cajas.length > 0) ? usuario.cajas : [] : [];
    _rol = (usuario.rol != null) ? listaRol.firstWhere((element) => element.id == usuario.rol.id) : (listaRol != null) ? (listaRol.length > 0) ? listaRol[0] : null : null;
    _sucursal = (usuario.sucursal != null) ? usuario.sucursal : (listaSucursal != null) ? (listaSucursal.length > 0) ? listaSucursal[0] : null : null;
    String initialValueRol = (usuario.rol != null) ? usuario.rol.descripcion : null;
    String initialValueSucursal = (usuario.sucursal != null) ? usuario.sucursal.nombre : null;
    
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {

            _showMultiSelect() async {
              var data = await showDialog<Set<int>>(
                context: context,
                builder: (context){
                  return MyMultiSelectDialog(
                    items: listaCaja.map<MyMultiSelectDialogItem>((e) => MyMultiSelectDialogItem(e.id, e.descripcion)).toList(),
                  );
                }
              );

              if(data == null)
                return;

              if(data.length > 0){
                for(int id in data){
                  Caja caja = listaCaja.firstWhere((element) => element.id == id, orElse: null);
                  if(caja == null)
                    continue;

                  if(_cajas.indexWhere((element) => element.id == caja.id) == -1)
                    setState(() => _cajas.add(caja));
                }
              }
            }

            _seleccionarRolYPermisosAdicionales() async {
              print("_seleccionarRolYPermisosAdicionales before: ${_rol.permisos}");
              var rol = await _showDialog(rol: _rol, permisos: permisos);
              print("_seleccionarRolYPermisosAdicionales: ${rol}");
              if(rol == null)
                return;

              permisos = rol.permisos;
              int idx = listaRol.indexWhere((element) => element.id == rol.id);
              if(idx != -1)
                setState(() => _rol = listaRol[idx]);

                _rol.permisos.forEach((element) {print("_seleccionarRolYPermisosAdicionales json: ${element.toJson()}");});

              
            }

            _guardar() async {
              usuario.nombres = _txtNombres.text;
              usuario.apellidos = _txtApellidos.text;
              usuario.usuario = _txtUsuario.text;
              if(_txtPassword.text.isNotEmpty)
                usuario.password = _txtPassword.text;

              if(usuario.contacto == null)
                usuario.contacto = Contacto();

              usuario.contacto.telefono = _txtTelefono.text;
              usuario.contacto.correo = _txtCorreo.text;
              usuario.cajas = _cajas;
              usuario.rol = _rol;
              usuario.empresa = Empresa(id: BigInt.one, nombre: "Empresa");
              usuario.sucursal = _sucursal;

              print("Guardar before permisos: ${permisos}");

              if(permisos == null)
                permisos = _rol.permisos;

              if(permisos.length == 0){
                Utils.showAlertDialog(context: context, title: "Error", content: "Debe asignarle por lo menos un permiso");
                return;
              }
              print("Guardar permisos: ${permisos}");

              usuario.permisos = permisos;

              setState(() => _cargando = true);
              var parsed = await UserService.store(context: context, usuario: usuario, db: db);
              print("_guardar parsed: $parsed");
              setState(() => _cargando = false);
              if(parsed["usuario"] != null)
                _addDataToList(Usuario.fromMap(parsed["usuario"]));
              Navigator.pop(context);
            }


            return MyAlertDialog(
              title: "${(usuario == null) ? 'Guardar' : 'Editar'}", 
              description: "Agrega todo tipo de usuarios como cajeros, cobradores, supervisores y administradores.",
              cargando: _cargando,
              content: Wrap(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                        onTap: () async {
                          File file = await FilePicker.getFile();
                          usuario.foto = await Utils.blobfileToUint(file); 
                          _streamControllerFoto.add(Utils.getWidgetUploadFoto(usuario));
                          
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyResizedContainer(medium: 1.5, child: MySubtitle(title: "Datos", fontSize: 17,)),
                          MyDropdown(
                            title: null,
                            isFlat: true,
                            medium: 3.8,
                            hint: "${(usuario.status == 1) ? 'Activo' : 'Desactivado'}",
                            elements: [["Activo", "Activo"], ["Desactivado", "Desactivado"]],
                            onTap: (data){
                              setState(() => usuario.status = (data == 'Activo') ? 1 : 0);
                            },
                          )
                          // FlatButton(onPressed: _seleccionarRolYPermisosAdicionales, child: Text("Permisos adicionales", style: TextStyle(color: Colors.blue[700], fontFamily: "GoogleSans", fontSize: 18, letterSpacing: 0.4)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtUsuario,
                        
                        title: "Usuario",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtPassword,
                        isPassword: true,
                        title: "Contraseña",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtNombres,
                        
                        title: "Nombres",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtApellidos,
                        title: "Apellidos",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtTelefono,
                        title: "Telefono",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyTextFormField(
                        controller: _txtCorreo,
                        title: "Correo",
                        medium: 2.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyDropdown(
                        medium: 3.25,
                        title: "Cajas",
                        hint: "${_cajas.length == 0 ? 'Ninguna' : _cajas.map((e) => e.descripcion).toList().join(", ")}",
                        onTap: _showMultiSelect,
                      )
                      // MyDropdownButton(
                      //   title: "Cajas",
                      //   medium: 3.25,
                      //   elements: (listaCaja.length > 0) ? listaCaja.map<String>((e) => e.descripcion).toList() : ["No hay datos"],
                      //   onChanged: (data){

                      //   }
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyDropdown(
                        medium: 3.25,
                        title: "Rol",
                        hint: "${_rol != null ? _rol.descripcion : 'Ninguno'}",
                        onTap: _seleccionarRolYPermisosAdicionales,
                      )
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    //   child: MyDropdownButton(
                    //     initialValue: (initialValueRol != null) ? initialValueRol : null,
                    //     title: "Rol",
                    //     medium: 3.25,
                    //     elements: (listaRol.length > 0) ? listaRol.map<String>((e) => e.descripcion).toList() : ["No hay datos"],
                    //     onChanged: (data){
                    //       int idx = listaRol.indexWhere((element) => element.descripcion == data);
                    //       if(idx != -1)
                    //         setState(() => _rol = listaRol[idx]);
                    //     }
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: MyDropdownButton(
                        initialValue: (initialValueSucursal != null) ? initialValueSucursal : null,
                        title: "Sucursal",
                        medium: 3.25,
                        elements: (listaSucursal.length > 0) ? listaSucursal.map<String>((e) => e.nombre).toList() : ["No hay datos"],
                        onChanged: (data){
                          int idx = listaSucursal.indexWhere((element) => element.nombre == data);
                          if(idx != -1)
                            setState(() => _sucursal = listaSucursal[idx]);
                        }
                      ),
                    )
                ],
              ), 
              okFunction: _guardar
            );
          }
        );
      }
    );
  }

  _getCustomerPhoto(String namePhoto, {size: 40, radius: 20}){
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

  _showDialogEliminar(Usuario usuario){
    bool cargando = false;
    showDialog(
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {
            return MyAlertDialog(
              title: "Eliminar usuario", 
              cargando: cargando,
                  isDeleteDialog: true,
                  content: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: "GoogleSans", letterSpacing: 0.4),
                      children: [
                        TextSpan(text: "Seguro que desea eliminar el usuario "),
                        TextSpan(text: "${usuario.nombres} ${usuario.apellidos}?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: "GoogleSans", letterSpacing: 0.4))
                      ]
                    )
                  ), 
                  okFunction: () async {
                    setState(() => cargando = true);
                    var parsed = await UserService.delete(context: context, usuario: usuario, db: db);
                    setState(() => cargando = false);
                    if(parsed["usuario"] != null)
                      _removeDataFromList(Usuario.fromMap(parsed["usuario"]));
                    Navigator.pop(context);
                  }
            );
          }
        );
      }
    );
  }

   Future<Rol> _showDialog({Rol rol, List<Permiso> permisos}) async {

    bool cargando = false;
    permisos = (permisos != null) ? permisos : [];
    Rol _rolDialog = rol;

    List<Rol> listaRolCopia = List.from(listaRol);
    List<Entidad> listaEntidadCopia = List.from(listaEntidad);

    print("_showDialog rol init: ${rol.descripcion}");

    listaEntidadCopia.forEach((element) {
      element.permisos.forEach((e) {
        e.seleccionado = false;
      });
    });

    if(rol != null && permisos.length == 0){
      listaEntidadCopia.forEach((entidad) {
        entidad.permisos.forEach((permiso) {
          bool esPermisoRol = _rolDialog.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1;
          permiso.seleccionado = (rol.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1) ? true : false;
          permiso.esPermisoRol = esPermisoRol;
        });
      });

    }
    else if(rol != null && permisos.length > 0){
      listaEntidadCopia.forEach((entidad) {
        entidad.permisos.forEach((permiso) {
          bool esPermisoRol = _rolDialog.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1;
          print("_showDialog esPermisoRol: $esPermisoRol}");
          permiso.seleccionado = ( esPermisoRol || permisos.indexWhere((permisoUsuario) => permiso.id ==  permisoUsuario.id) != -1) ? true : false;
          permiso.esPermisoRol = esPermisoRol;
        });
      });
    }

    List<Widget> listaWidget = [];

    return await showDialog(context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (context, setState) {

            Widget _myPermissionCheckbox(Permiso permiso){
              return MyCheckBox(
                // color: (permiso.esPermisoRol) ? Colors.green : null,
                disable: permiso.esPermisoRol,
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
              bool todosLosPermisosDeEstaEntidadPertenencenAEsteRol = (entidad.permisos.length == entidad.permisos.where((element) => element.seleccionado == true).toList().length && entidad.permisos.length == entidad.permisos.where((element) => element.esPermisoRol == true).toList().length);
              return AbsorbPointer(
                absorbing: todosLosPermisosDeEstaEntidadPertenencenAEsteRol,
                child: Checkbox(
                      onChanged: (data){ 
                        setState(() {
                        // _ckbExpansion = data;
                         entidad.permisos.forEach((element) => element.seleccionado = data);
                      });
                      }, 
                    activeColor: todosLosPermisosDeEstaEntidadPertenencenAEsteRol ? Colors.grey : null,
                    value: entidad.permisos.length == entidad.permisos.where((element) => element.seleccionado == true).toList().length
                  ),
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

            _permisosChanged(dynamic data){
              setState((){ 
                      // for(Entidad entidad in listaEntidadCopia){
                      // for(Permiso p in entidad.permisos){
                      //   p.esPermisoRol = true;
                      // }
                      // _permisosChanged();
                      _rolDialog = data;
                      print("setState rol: ");
                      for(Entidad element in listaEntidadCopia) {
                        for(Permiso e in element.permisos) {
                          e.seleccionado = false;
                          e.esPermisoRol = false;
                        }
                      }

                      // if(rol != null && permisos.length == 0){
                        // print(set)
                        for(Entidad entidad in listaEntidadCopia) {
                          for(Permiso permiso in entidad.permisos) {
                            // if(init)
                            
                              if (_rolDialog.id != rol.id) {
                                bool esPermisoRol = _rolDialog.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1;
                                permiso.seleccionado = (_rolDialog.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1) ? true : false;
                                permiso.esPermisoRol = esPermisoRol;
                              }else{
                                bool esPermisoRol = _rolDialog.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1;
                                print("_showDialog esPermisoRol: ${_rolDialog.permisos.length}");
                                // if (init) {
                                permiso.seleccionado = ( esPermisoRol || permisos.indexWhere((permisoUsuario) => permiso.id ==  permisoUsuario.id) != -1) ? true : false;
                                permiso.esPermisoRol = esPermisoRol;
                              }
                            // else
                            //   setState(() => permiso.seleccionado = (rol.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1) ? true : false);
                          }
                        }

                      // }
                      // else if(rol != null && permisos.length > 0){
                      //   for(Entidad entidad in listaEntidadCopia) {
                      //     for(Permiso permiso in entidad.permisos) {
                      //       bool esPermisoRol = rol.permisos.indexWhere((permisoRol) => permisoRol.id == permiso.id) != -1;
                      //       print("_showDialog esPermisoRol: ${rol.permisos.length}");
                      //       // if (init) {
                      //         permiso.seleccionado = ( esPermisoRol || permisos.indexWhere((permisoUsuario) => permiso.id ==  permisoUsuario.id) != -1) ? true : false;
                      //         permiso.esPermisoRol = esPermisoRol;
                      //       // }else{
                      //       //   setState(() {
                      //       //     permiso.seleccionado = ( esPermisoRol || permisos.indexWhere((permisoUsuario) => permiso.id ==  permisoUsuario.id) != -1) ? true : false;
                      //       //     permiso.esPermisoRol = esPermisoRol;
                      //       //   });
                      //       // }
                      //     }
                      //   }
                      // }
                    });
                  
            }

            

            

            listaWidget = listaEntidadCopia.map<Widget>((e) => _permissionScreen(e)).toList();
            listaWidget.insert(0, Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MyDropdown(
                  title: "Rol",
                  hint: (_rolDialog != null) ? _rolDialog.descripcion : null,
                  medium: 1.0,
                  elements: listaRolCopia.map((e) => [e, e.descripcion]).toList(),
                  onTap: _permisosChanged
                ),
              ),
              MySubtitle(title: "Permisos", fontSize: 16,),
              MyDescripcon(title: "Los check de color azul son los permisos adicionales que usted a agregado y los de color gris son los permisos por defecto que tiene el rol y no se pueden modificar", fontSize: 15,)
            ],));

                _back({Rol rol}){
                  Navigator.pop(context, rol);
                }

                _guardar() async {
                  // if(_formKey.currentState.validate()){
                    setState(() => cargando = true);
                    List<Permiso> permisosToReturn = [];
                    
                    for(Entidad element in listaEntidadCopia) {
                      for(Permiso element2 in element.permisos) {
                    print("_guardar for in permisosToReturn: ${element2.toJson()}");

                        if(element2.seleccionado)
                          permisosToReturn.add(element2);
                      }
                    };
                    // var parsed = await RoleService.store(context: context, rol: rolToSave);
                    setState(() => cargando = false);
                    Rol _rolToReturn = Rol(id: _rolDialog.id, permisos: permisosToReturn);
                    _back(rol: _rolToReturn);
                  // }
                }

            return MyAlertDialog(
              title: "Permisos adicionales", 
              description: "Si los permisos por defectos que tiene este Rol no cumplen con lo que deseas, añade permisos especiales a este usuario para que cumpla con todas las caracteristicas que usted desea.",
              content: Wrap(children: listaWidget),
              // content: Wrap(children: [
              //   StreamBuilder(
              //     stream: _streamControllerPermiso.stream,
              //     builder: (context, snapshot){
              //       if(snapshot.hasData == false)
              //         return SizedBox();

              //       return Column(
              //         children: listaWidget = listaEntidadCopia.map<Widget>((e) => _permissionScreen(e)).toList(),
              //       );                 
              //     }
              //   )
              // ]),
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


  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _streamControllerFoto = BehaviorSubject();
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
    return myScaffold(
      context: context,
      cargando: false,
      usuarios: true,
      body: [
        MyHeader(title: "Agregar usuario", subtitle: "Agrega todo tipo de usuarios como cajeros, cobradores, supervisores y administradores.", function: _showDialogGuardar, actionFuncion: "Guardar", cargando: _cargando,),
        Expanded(
          child: StreamBuilder<List<Usuario>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData == false)
                return Center(child: CircularProgressIndicator());

              if(snapshot.data.length == 0 && listaUsuario.length == 0)
                return Center(child: MyEmpty(title: "No hay usuarios; crear un nuevo usuario.", icon: Icons.supervised_user_circle_outlined, titleButton: "Crea un usuario nuevo", onTap: _showDialogGuardar,),);
              else
                return MyScrollbar(
                  child: Column(
                      children: [
                        Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: MySubtitle(title: "${snapshot.data.length} Usuarios", fontSize: 20, fontWeight: FontWeight.w500,),
                      ),
                      Stack(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        //  Wrap(
                        //    children: [
                        //       MyDatePicker(initialHint: "Todas las fechas", title: "Fecha inicial", isDropdown: true, initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaInicialChanged),
                        //       MyDatePicker(initialHint: "Todas las fechas", title: "Fecha final", isDropdown: true, initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaFinalChanged, ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 40.0),
                        //         child: FlatButton(onPressed: (){}, child: Text("Buscar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)))),
                        //       ),
                        //       // Padding(
                        //       //   padding: const EdgeInsets.only(top: 33.0),
                        //       //   child: myIconButton(function: _filter, icon: Icons.search, color: Colors.green),
                        //       // ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 40.0),
                        //         child: FlatButton(onPressed: _showDialogFiltrar, child: Text("Mas filtros...", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.5)))),
                        //       ),
                              
                        //    ],
                        //  ),
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
                              child: MySearchField(controller: _txtSearch, onChanged: _search, hint: "Buscar por usuario, nombre o apellidos...", xlarge: 3.0,),
                            ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTable(
                              isScrolled: false,
                              columns: ["Nombres", "Usuario", "Rol", "Sucursal", "Activo"], 
                              rows: snapshot.data.map((e) => [e, Row(children: [_getCustomerPhoto(e.nombreFoto), Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("${e.nombres} ${e.apellidos}"),
                              )]), "${e.usuario}", "${e.rol.descripcion}", "${e.sucursal.nombre}", "${e.status == 1 ? 'Si' : 'No'}"]).toList(),
                              // indexCellKeyToReturnOnClick: ,
                              onTap: (Usuario data){
                                _showDialogGuardar(usuario: data);
                                print("OnTap: ${data.toJson()}");
                              },
                              delete: (Usuario data){
                                _showDialogEliminar(data);
                              },
                            ),
                          ),
                        ],
                      )
                    ]
                  ),
                );
            }
          )
        )
      ]
    );
  }
}