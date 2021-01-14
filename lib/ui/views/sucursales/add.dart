import 'dart:async';
import 'dart:html';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/sucursal.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:rxdart/rxdart.dart';

class SucursalesAdd extends StatefulWidget {
  @override
  _SucursalesAddState createState() => _SucursalesAddState();
}

class _SucursalesAddState extends State<SucursalesAdd> {
  StreamController<Widget> _streamControllerFoto;
  var _txtNombre = TextEditingController();
  var _txtDireccion = TextEditingController();
  var _txtCiudad = TextEditingController();
  var _txtTelefono1 = TextEditingController();
  var _txtTelefono2 = TextEditingController();
  var _txtGerenteSucursal = TextEditingController();
  var _txtGerenteCobros = TextEditingController();
  Sucursal _sucursal = Sucursal();
  bool _status = false;
  bool _cargando = false;

  _guardar(){

  }

  _onStatusChanged(bool value){
    setState(() => _status = value);
  }

  _init(){
    _streamControllerFoto.add(Utils.getSucursalFoto(_sucursal, radius: 30));
  }

  @override
  void initState() {
    // TODO: implement initState
    _streamControllerFoto = BehaviorSubject();
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      sucursales: true,
      body: [
        MyHeader(title: "Agregar sucursales", subtitle: "Las sucursales le permitiran separar sus puntos de ventas.", function: _guardar, actionFuncion: "Guardar",),
        Expanded(
          child: MyScrollbar(
          child: Wrap(
            children: [
              InkWell(
                onTap: () async {
                  File file = await FilePicker.getFile();
                  _sucursal.foto = await Utils.blobfileToUint(file); 
                  _streamControllerFoto.add(Utils.getSucursalFoto(_sucursal));
                  
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
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtNombre,
                  title: "Nombre sucursal",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtDireccion,
                  title: "Direccion",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtCiudad,
                  title: "Ciudad",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtTelefono1,
                  title: "Telefono1",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtTelefono2,
                  title: "Telefono2",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtGerenteSucursal,
                  title: "Gerente sucursal",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: _txtGerenteCobros,
                  title: "Gerente Cobros",
                  enabled: true,
                  large: 1,
                  
                ),
              ),
              // MyCheckBox(title: "Activa", value: _status, onChanged: _onStatusChanged,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("Activar desembolso"),
                    ),
                    Switch(
                      onChanged: _onStatusChanged,
                      value: _status,
                    )
                  ],
                )
            ],
          ),
        )
      
        )
      ]
    );
  }
}