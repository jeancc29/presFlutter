import 'dart:async';
import 'dart:html';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/empresa.dart';
import 'package:prestamo/core/models/estado.dart';
import 'package:prestamo/core/services/companyservice.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:rxdart/rxdart.dart';

class ConfiguracionEmpresaScreen extends StatefulWidget {
  @override
  _ConfiguracionEmpresaScreenState createState() => _ConfiguracionEmpresaScreenState();
}

class _ConfiguracionEmpresaScreenState extends State<ConfiguracionEmpresaScreen> {
  var _txtNombre = TextEditingController();
  var _txtCorreo = TextEditingController();
  var _txtTelefono = TextEditingController();
  var _txtCelular = TextEditingController();
  var _txtRnc = TextEditingController();
  StreamController<Empresa> _streamController;
  StreamController<Widget> _streamControllerFoto;
  StreamController<List<Ciudad>> _streamControllerCiudades;
  StreamController<List<Estado>> _streamControllerEstados;
  bool _cargando = false;
  List<Ciudad> listaCiudad = [];
  List<Estado> listaEstado = [];
  Empresa _empresa = Empresa();
  Direccion _direccion = Direccion();

  _init() async {
    var parsed = await CompanyService.index(context: context);
    print("_init: $parsed");
    _empresa = (parsed["empresa"] != null) ? Empresa.fromMap(parsed["empresa"]) : Empresa();
    listaCiudad = (parsed["ciudades"] != null) ? parsed["ciudades"].map<Ciudad>((json) => Ciudad.fromMap(json)).toList() : [];
    listaEstado = (parsed["estados"] != null) ? parsed["estados"].map<Estado>((json) => Estado.fromMap(json)).toList() : [];
    _streamControllerCiudades.add(listaCiudad);
    _streamControllerEstados.add(listaEstado);
     _streamControllerFoto.add(Utils.getWidgetUploadFoto(_empresa, radius: 30));
    _streamController.add(_empresa);
  }

  _estadoChange(data){
      print("Estado change: ${data}");
      Estado estado = listaEstado.firstWhere((element) => element.nombre == data);
      if(_direccion == null)
        _direccion = Direccion();

      _direccion.idEstado = estado.id;
      _direccion.estado = estado;

      if(listaCiudad != null){
        _streamControllerCiudades.add(listaCiudad.where((element) => element.idEstado == estado.id).toList());
        Ciudad ciudad = listaCiudad[0];
        _direccion.idCiudad = ciudad.id;
        _direccion.ciudad = ciudad;
      }
    }

  _ciudadChange(data){
      print("Estado change: ${data}");
      Ciudad ciudad = listaCiudad.firstWhere((element) => element.nombre == data);
      if(_direccion == null)
        _direccion = Direccion();

      _direccion.idCiudad = ciudad.id;
      _direccion.ciudad = ciudad;
    }


  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _streamControllerFoto = BehaviorSubject();
    _streamControllerEstados = BehaviorSubject();
    _streamControllerCiudades = BehaviorSubject();
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      configuracionEmpresa: true,
      body: [
        MyHeader(title: "Empresa", subtitle: "Configura los datos de su empresa nombre, foto, telefono, etc. para que estos se reflejen en los contratos y recibos.",),
        Expanded(
          child: StreamBuilder<Empresa>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData == false)
                return Center(child: CircularProgressIndicator(),);


              return MyScrollbar(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Wrap(
                        children: [
                          InkWell(
                            onTap: () async {
                              File file = await FilePicker.getFile();
                              _empresa.foto = await Utils.blobfileToUint(file); 
                              _streamControllerFoto.add(Utils.getWidgetUploadFoto(_empresa, radius: 30));
                              
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
                          // LayoutBuilder(
                          //   builder: (context, boxconstraint) {
                          //     return MySubtitle(title: "Datos");
                          //   }
                          // ),
                          MyResizedContainer(
                            xlarge: 1.3,
                            // color: Colors.red,
                            child: Wrap(
                              children: [
                                MySubtitle(title: "Datos"),
                                MyTextFormField(
                                  title: "Nombre",
                                  hint: "Nombre",
                                  controller: _txtNombre,
                                  isRequired: true,
                                ),   
                                MyTextFormField(
                                  title: "Correo",
                                  hint: "Correo",
                                  controller: _txtCorreo,
                                  isRequired: true,
                                ),     
                                MyTextFormField(
                                  title: "Telefono",
                                  hint: "Telefono",
                                  controller: _txtTelefono,
                                  isRequired: true,
                                ),        
                                MyTextFormField(
                                  title: "Celular",
                                  hint: "Celular",
                                  controller: _txtCelular,
                                  isRequired: true,
                                ),    
                                
                              ],
                            )
                          ),

                          MyTextFormField(
                            title: "Rnc",
                            hint: "Rnc",
                            controller: _txtRnc,
                            isRequired: true,
                            isDigitOnly: true,
                          ),  
                          StreamBuilder<List<Estado>>(
                            stream: _streamControllerEstados.stream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                List<String> lista = snapshot.data.map((e) => e.nombre).toList();
                                return MyDropdownButton(
                                  medium: 2, 
                                  title: "Provincia", 
                                  onChanged: _estadoChange, 
                                  elements: lista,
                                  xlarge: 4,
                                );
                              }
                              return MyDropdownButton(
                                medium: 2, 
                                title: "Estado", 
                                onChanged: (data){

                                }, 
                                elements: ["No hay datos"],
                                xlarge: 4,
                              );
                            }
                          ),
                          StreamBuilder<List<Ciudad>>(
                            stream: _streamControllerCiudades.stream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                List<String> lista = snapshot.data.map((e) => e.nombre).toList();
                                return MyDropdownButton(
                                  medium: 2, 
                                  title: "Ciudad", 
                                  onChanged: _ciudadChange, 
                                  elements: lista,
                                  xlarge: 4,
                                );
                              }
                              return MyDropdownButton(
                                medium: 2, 
                                title: "Ciudad", 
                                onChanged: (data){

                                }, 
                                elements: ["No hay datos"],
                                xlarge: 4,
                              );
                            }
                          ),     
                                
                        ],
                      ),
                    ),
                  );
            }
          )
            
        ),
      ]
    );
  }
}