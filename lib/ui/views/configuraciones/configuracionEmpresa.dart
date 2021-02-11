import 'dart:async';
import 'dart:html';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/empresa.dart';
import 'package:prestamo/core/models/estado.dart';
import 'package:prestamo/core/models/moneda.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/services/companyservice.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ConfiguracionEmpresaScreen extends StatefulWidget {
  @override
  _ConfiguracionEmpresaScreenState createState() => _ConfiguracionEmpresaScreenState();
}

class _ConfiguracionEmpresaScreenState extends State<ConfiguracionEmpresaScreen> {
  AppDatabase db;
  var _txtNombre = TextEditingController();
  var _txtCorreo = TextEditingController();
  var _txtTelefono = TextEditingController();
  var _txtCelular = TextEditingController();
  var _txtRnc = TextEditingController();
  var _txtDireccion = TextEditingController();
  var _txtDiasGracia = TextEditingController();
  var _txtPorcentajeMora = TextEditingController();
  StreamController<Empresa> _streamController;
  StreamController<Empresa> _streamControllerFoto;
  StreamController<List<Ciudad>> _streamControllerCiudades;
  StreamController<List<Estado>> _streamControllerEstados;
  bool _cargando = false;
  List<Ciudad> listaCiudad = [];
  List<Estado> listaEstado = [];
  List<Moneda> listaMoneda = [];
  Ciudad _ciudad;
  Estado _estado;
  Moneda _moneda;
  Empresa _empresa = Empresa();
  Direccion _direccion = Direccion();
  List<Tipo> listaTipoMora = [];
  Tipo _tipoMora = Tipo();

  _init() async {
    var parsed = await CompanyService.index(context: context, db: db);
    print("_init: ${parsed["empresa"]}");
    _empresa = (parsed["empresa"] != null) ? Empresa.fromMap(parsed["empresa"]) : Empresa();
    listaCiudad = (parsed["ciudades"] != null) ? parsed["ciudades"].map<Ciudad>((json) => Ciudad.fromMap(json)).toList() : [];
    listaEstado = (parsed["estados"] != null) ? parsed["estados"].map<Estado>((json) => Estado.fromMap(json)).toList() : [];
    listaTipoMora = (parsed["tipos"] != null) ? parsed["tipos"].map<Tipo>((json) => Tipo.fromMap(json)).toList() : [];
    listaMoneda = (parsed["monedas"] != null) ? parsed["monedas"].map<Moneda>((json) => Moneda.fromMap(json)).toList() : [];
    _selectFirstElementOfAllDropdown();
    _fillFields();
    // if(_empresa == null)
      
    print("_init ciudad: ${_ciudad.toJson()}");
    _streamControllerCiudades.add(listaCiudad);
    _streamControllerEstados.add(listaEstado);
     _streamControllerFoto.add(_empresa);
    _streamController.add(_empresa);
  }

  _fillFields(){
    _txtNombre.text = _empresa.nombre;
    _txtDiasGracia.text = (_empresa.diasGracia == null) ? null : _empresa.diasGracia.toString();
    _txtPorcentajeMora.text = (_empresa.porcentajeMora == null) ? null : _empresa.porcentajeMora.toString();
    _txtCorreo.text = (_empresa.contacto != null) ? _empresa.contacto.correo.toString() : null;
    _txtCelular.text = (_empresa.contacto != null) ? _empresa.contacto.celular.toString() : null;
    _txtTelefono.text = (_empresa.contacto != null) ? _empresa.contacto.telefono.toString() : null;
    _txtRnc.text = (_empresa.contacto != null) ? _empresa.contacto.rnc.toString() : null;
    _txtDireccion.text = (_empresa.direccion != null) ? _empresa.direccion.direccion.toString() : null;

    if(_empresa.direccion != null){
      setState(() {
        if(_empresa.direccion.ciudad != null)
          _ciudad = _empresa.direccion.ciudad;
        if(_empresa.direccion.estado != null)
          _estado = _empresa.direccion.estado;
      });
    }
  }

  _selectFirstElementOfAllDropdown(){
    _estado = (listaEstado.length > 0) ? listaEstado[0] : null;
    _ciudad = (listaCiudad.length > 0) ? listaCiudad[0] : null;
    _tipoMora = (listaTipoMora.length > 0) ? listaTipoMora[0] : null;
    _moneda = (listaMoneda.length > 0) ? listaMoneda[0] : null;
  }

  _estadoChange(data){
      print("Estado change: ${data}");
      Estado estado = listaEstado.firstWhere((element) => element.nombre == data);
      if(_direccion == null)
        _direccion = Direccion();

      _estado = estado;

      if(listaCiudad != null){
        var listaCiudadesDelEstado = listaCiudad.where((element) => element.idEstado == estado.id).toList();
        _streamControllerCiudades.add(listaCiudadesDelEstado);
        if(listaCiudadesDelEstado.length > 0)
          _ciudad = listaCiudadesDelEstado[0];
        else
          _ciudad = null;
      }
    }

  _ciudadChange(data){
      print("Estado change: ${data}");
      Ciudad ciudad = listaCiudad.firstWhere((element) => element.nombre == data);
      _ciudad = ciudad;
    }

  _tipoMoraChange(data){
    setState(() => _tipoMora = listaTipoMora.firstWhere((element) => element.descripcion == data));
  }

  _monedaChange(data){
    setState(() => _moneda = listaMoneda.firstWhere((element) => element.nombre == data));
  }


  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _streamControllerFoto = BehaviorSubject();
    _streamControllerEstados = BehaviorSubject();
    _streamControllerCiudades = BehaviorSubject();
    super.initState();
  }

  _customerScreen(AsyncSnapshot<Empresa> snapshot){
    if(snapshot.hasData)
      // print("_customerScreen ${snapshot.data.toJson()}");
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: 
      // ListTile(
      //   leading: Utils.getCustomerPhoto(widget.prestamo.cliente.nombreFoto, size: 120),
      //   title: Text("${snapshot.data.cliente.nombres} ${snapshot.data.cliente.apellidos}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, letterSpacing: 0.2, fontFamily: "GoogleSans"),),
      //   subtitle: Text("031-0563805-4"),
      // )
      Row(children: [
        InkWell(
          onTap: () async {
            File file = await FilePicker.getFile();
            _empresa.foto = await Utils.blobfileToUint(file); 
            _streamControllerFoto.add(_empresa);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: StreamBuilder<Empresa>(
              stream: _streamControllerFoto.stream,
              builder: (context, snapshot) {
                // return Utils.getCustomerPhoto(snapshot.data.nombreFoto, size: 80);
                if(snapshot.hasData == false)
                  return SizedBox();
                return Utils.getWidgetUploadFoto(snapshot.data, size: 80);
              }
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${snapshot.data.nombre == null ? 'Nombre empresa' : snapshot.data.nombre}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, fontFamily: "GoogleSans"),),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Wrap(children: [
                MyDescripcon(title: "${snapshot.data.contacto == null  ? 'Correo' : snapshot.data.contacto.correo}", fontSize: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                ),
                MyDescripcon(title: "${snapshot.data.contacto == null  ? 'Telefono' : snapshot.data.contacto.telefono}", fontSize: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                ),
                MyDescripcon(title: "${snapshot.data.contacto == null  ? 'Rnc' : snapshot.data.contacto.rnc}", fontSize: 15,),

              ],),
            )
          ],
        )
      ],),
    );
                      
  }


  _guardar() async {
    setState(() => _cargando = true);
    _empresa.nombre = (_txtNombre.text != null) ? _txtNombre.text : '';
    _empresa.diasGracia = (_txtDiasGracia.text != null) ? Utils.toInt(_txtDiasGracia.text) : null;
    _empresa.porcentajeMora = (_txtPorcentajeMora.text != null) ? Utils.toDouble(_txtPorcentajeMora.text) : null;
    _empresa.tipoMora = _tipoMora;

    if(_empresa.contacto == null)
      _empresa.contacto = Contacto();

    _empresa.contacto.correo = _txtCorreo.text;
    _empresa.contacto.telefono = _txtTelefono.text;
    _empresa.contacto.celular = _txtCelular.text;
    _empresa.contacto.rnc = _txtRnc.text;

    if(_empresa.direccion == null)
      _empresa.direccion = Direccion();

    // if(_empresa.direccion.estado == null)
    //   _empresa.direccion.estado = Estado();

    _empresa.direccion.estado = _estado;

    // if(_empresa.direccion.ciudad == null)
    //   _empresa.direccion.ciudad = Ciudad();

    _empresa.direccion.ciudad = _ciudad;
    _empresa.direccion.direccion = _txtDireccion.text;

    _empresa.moneda = _moneda;

    print("_guardar ciudad: ${_empresa.direccion.ciudad.toJson()}");
    var parsed = await CompanyService.store(context: context, empresa: _empresa, db: db);
    _empresa = Empresa.fromMap(parsed["empresa"]);
    setState(() => _cargando = false);
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
      configuracionEmpresa: true,
      body: [
        MyHeader(title: "Empresa", subtitle: "Configura los datos de su empresa nombre, foto, telefono, etc. para que estos se reflejen en los contratos y recibos.", actionFuncion: "Guardar", function: _guardar, cargando: _cargando,),
        Expanded(
          child: StreamBuilder<Empresa>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData == false)
                return Center(child: CircularProgressIndicator(),);


              return MyScrollbar(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Wrap(
                        children: [
                          // InkWell(
                          //   onTap: () async {
                          //     File file = await FilePicker.getFile();
                          //     _empresa.foto = await Utils.blobfileToUint(file); 
                          //     _streamControllerFoto.add(_empresa);
                              
                          //     // _futureFoto = Utils.getClienteFoto(_cliente);
                          //     // _streamControllerFotoCliente.add(file);
                          //     // IO.File(file.relativePath);
                          //     // // base64.decode(file);
                          //     // setState(() {
                          //     //   _image = file;
                          //     // });
                          //     // _startFilePicker();
                          //     // print("Archivo: ${file.name}");
                          //     // Blo
                          //     // print("ArchivoType: ${file.}");
                          //   },
                          //   child: 
                          //   StreamBuilder<Empresa>(
                          //     stream: _streamControllerFoto.stream,
                          //     builder: (context, snapshot) {
                          //           if(snapshot.hasData)
                          //             return Padding(
                          //               padding: const EdgeInsets.all(25.0),
                          //               child: snapshot.data,
                          //             );
                                    
                          //           return SizedBox();
                          //     }
                          //   )
                          //   // StreamBuilder<File>(
                          //   //   stream: _streamControllerFotoCliente.stream,
                          //   //   builder: (context, snapshot) {
                          //   //     if(snapshot.hasData)
                          //   //       _cliente.foto = snapshot.data; 
                          //   //     return Container(
                          //   //       // color: ,
                          //   //       width: 130,
                          //   //       height: 130,
                          //   //       child:  ClipRRect(
                          //   //         borderRadius: BorderRadius.circular(10),
                          //   //         child: Container(
                          //   //           child: Utils.getClienteFoto(_cliente),
                          //   //         ),
                          //   //       ),
                          //   //     );
                          //   //   }
                          //   // ),
                          // ),
                          _customerScreen(snapshot),
                          MyResizedContainer(
                            xlarge: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(),
                            ),
                          ),
                          // LayoutBuilder(
                          //   builder: (context, boxconstraint) {
                          //     return MySubtitle(title: "Datos");
                          //   }
                          // ),
                          MySubtitle(title: "Datos", fontSize: 18,),
                          MyTextFormField(
                            title: "Nombre",
                            hint: "Nombre",
                            controller: _txtNombre,
                            isRequired: true,
                            xlarge: 4,
                          ),   
                          MyTextFormField(
                            title: "Correo",
                            hint: "Correo",
                            controller: _txtCorreo,
                            isRequired: true,
                            xlarge: 4,
                          ),     
                          MyTextFormField(
                            title: "Telefono",
                            hint: "Telefono",
                            controller: _txtTelefono,
                            isRequired: true,
                            xlarge: 4,
                          ),        
                          MyTextFormField(
                            title: "Celular",
                            hint: "Celular",
                            controller: _txtCelular,
                            isRequired: true,
                            xlarge: 4,
                          ),

                          MyTextFormField(
                            title: "Rnc",
                            hint: "Rnc",
                            controller: _txtRnc,
                            isRequired: true,
                            isDigitOnly: true,
                            xlarge: 4,
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
                                  initialValue: (_estado != null) ? _estado.nombre : null,
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
                                print("ComboCiudad: ${_ciudad == null}");
                                List<String> lista = snapshot.data.map((e) => e.nombre).toList();
                                return MyDropdownButton(
                                  medium: 2, 
                                  title: "Ciudad", 
                                  onChanged: _ciudadChange, 
                                  elements: lista,
                                  xlarge: 4,
                                  initialValue: (_ciudad != null) ? _ciudad.nombre : null,
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
                          MyTextFormField(
                            title: "Direccion",
                            hint: "Direccion",
                            controller: _txtDireccion,
                            // xlarge: 4.8,
                            xlarge: 4,
                          ),   
                          MyDropdownButton(
                            medium: 2, 
                            title: "Moneda", 
                            onChanged: _monedaChange, 
                            elements: (listaMoneda.length == 0) ? ["No hay datos"] : listaMoneda.map((e) => e.nombre).toList(),
                            xlarge: 4,
                          ),

                          MySubtitle(title: "Mora", fontSize: 18,),
                          MyTextFormField(
                            title: "Dias de gracia",
                            hint: "Dias de gracia",
                            controller: _txtDiasGracia,
                            isRequired: true,
                            isDigitOnly: true,
                            xlarge: 4.8,
                          ),
                          MyTextFormField(
                            title: "Porcentaje mora",
                            hint: "Porcentaje mora",
                            controller: _txtPorcentajeMora,
                            isDecimal: true,
                            xlarge: 4.8,
                          ),

                          MyDropdownButton(
                            medium: 2, 
                            title: "Tipo mora", 
                            onChanged: _tipoMoraChange, 
                            elements: (listaTipoMora.length == 0) ? ["No hay datos"] : listaTipoMora.map((e) => e.descripcion).toList(),
                            xlarge: 4,
                          )
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