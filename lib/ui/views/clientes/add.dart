import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/ui/views/clientes/dialogreferencia.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myexpansiontile.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:rxdart/rxdart.dart';

class ClientesAdd extends StatefulWidget {
  @override
  _ClientesAddState createState() => _ClientesAddState();
}

class _ClientesAddState extends State<ClientesAdd> with TickerProviderStateMixin {
  File _image;
  StreamController<List<Referencia>> _streamBuilderReferencia;
  ScrollController _scrollController;
  ScrollController _scrollControllerTrabajo;
  var _txtDocumento = TextEditingController();
  var _txtNombres = TextEditingController();
  var _txtApellidos = TextEditingController();
  var _txtApodo = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _fechaNacimiento = DateTime.now();
  var _txtNumeroDependientes = TextEditingController();
  var _txtDireccion = TextEditingController();
  var _txtSector = TextEditingController();
  var _txtTelefeno = TextEditingController();
  var _txtCelular = TextEditingController();
  var _txtFax = TextEditingController();
  var _txtTiempoEnResidencia = TextEditingController();
  var _txtReferidoPor = TextEditingController();

  var _txtDireccionTrabajo = TextEditingController();
  var _txtNumeroTrabajo = TextEditingController();
  var _txtSectorTrabajo = TextEditingController();
  var _txtCiudadTrabajo = TextEditingController();
  var _txtTelefonoTrabajo = TextEditingController();
  var _txtExtensionTrabajo = TextEditingController();
  var _txtFaxTrabajo = TextEditingController();
  var _txtOcupacionTrabajo = TextEditingController();
  var _txtDepartamentoTrabajo = TextEditingController();
  var _txtSupervisorTrabajo = TextEditingController();
  var _txtIngresosTrabajo = TextEditingController();
  var _txtOtrosIngresosTrabajo = TextEditingController();
  DateTime _fechaIngresoTrabajo = DateTime.now();

  var _txtNombreNegocio = TextEditingController();
  var _txtTipoNegocio = TextEditingController();
  var _txtTiempoExistenciaNegocio = TextEditingController();
  var _txtDireccionNegocio = TextEditingController();
  var _txtRutasdeventaNegocio = TextEditingController();

  var _tabController;
  bool _cargando = false;
  // var _controller = TabController(initialIndex: 0)
  List<Referencia> listaReferencia = List();

  _agregarReferencia() async {
    Referencia referencia = await showDialog(context: context, builder: (context){return DialogReferencia(context: context,);});
    if(referencia != null){
      listaReferencia.add(referencia);
      _streamBuilderReferencia.add(listaReferencia);
    }
    print("Referencia: ${referencia.toJson()}");
  }

  _removerReferencia(Referencia referencia){
    if(referencia != null){
      listaReferencia.remove(referencia);
      _streamBuilderReferencia.add(listaReferencia);
    }
  }

  // variable to hold image to be displayed 

      Uint8List uploadedImage;

//method to load image and update `uploadedImage`


    _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {
                    setState(() {
                      uploadedImage = reader.result;
                      
                    });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            String option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
    }

  @override
  void initState() {
    // TODO: implement initState
    _streamBuilderReferencia = BehaviorSubject();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollControllerTrabajo = ScrollController();
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
          //  Padding(
          //       padding: const EdgeInsets.only(top: 2.0, right: 2),
          //       child: Container(
          //         width: 60,
          //         height: 60,
          //         child:  Container(
          //           child: Image(image: AssetImage('images/p1_sin_fondo.png'), ),
          //         ),
          //       ),
          //     ),
          
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
        Visibility(
          visible: MediaQuery.of(context).size.width > ScreenSize.md,
          child: Container(
            // color: Colors.red,
            width: 260,
            height: MediaQuery.of(context).size.height,
            child: ListView(children: [
              SizedBox(height: 5,),
              // Row(
              //   children: [
              //   Padding(
              //     padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //     child: Icon(Icons.apps, color: Colors.black,),
              //   ),
              //   Text("Todas las apps", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), ),),
              // ],),
              // Container(
              //   color: Colors.transparent,
              //   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Row(
              //     children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //       child: Icon(Icons.apps, color: Colors.black,),
              //     ),
              //     Text("Todas las apps", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), ),),
              //   ],),
              // ),
              // Container(
              //   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   decoration: BoxDecoration(
              //     color: Colors.blue[50],
              //     borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              //   ),
              //   child: Row(
              //     children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //       child: Icon(Icons.tablet_mac, color: Utils.fromHex("#1a73e8"),),
              //     ),
              //     Text("Recibidos", style: TextStyle(fontSize: 14, color: Utils.fromHex("#1a73e8"), fontWeight: FontWeight.bold ),),
              //   ],),
              // ),
              MyListTile(title: "Inicio", icon: Icons.apps),
              MyListTile(title: "Clientes", icon: Icons.people, selected: true),
              // MyListTile(title: "CUlo", icon: Icons.recent_actors),
              MyListTile(title: "Usuarios y permisos", icon: Icons.recent_actors),
              MyListTile(title: "Pagos", icon: Icons.payment, selected: false,),
              MyExpansionTile(
                title: "Descargar informes", 
                icon: Icons.file_download, 
                listaMylisttile: [MyListTile(title: "Comentarios", icon: null), MyListTile(title: "Estadisticas", icon: null)]
              )
            ],),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text("Clientes", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                  // ),
                  // Padding(
                  // padding: const EdgeInsets.all(8.0),
                  // child: Text("Clientes", style: TextStyle(fontFamily: 'OpenSans', fontSize: 27, fontWeight: FontWeight.w700)),
                  // ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Clientes", style: TextStyle(fontFamily: 'Roboto', fontSize: 27, fontWeight: FontWeight.w600)),
                  ),
                  
                  // SizedBox(
                  //   child: RaisedButton(
                  //     color: Utils.colorPrimaryBlue,
                  //     child: Text("Guardar", style: TextStyle(color: Colors.white),),
                  //     onPressed: (){},
                  //   ),
                  // )
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: SizedBox(
                      width: 145,
                      child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: RaisedButton(
                                  elevation: 0,
                                  color: Utils.colorPrimaryBlue,
                                  child: Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  onPressed: (){
                                    // _connect();
                                    if(_formKey.currentState.validate()){
                                      // _guardar();
                                    }
                                  },
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 22, left: 10),
              //   child: Divider(height: 5, thickness: 0.3, color: Colors.black,),
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 3.0),
              //       child: Text("Todos los datos para agregar o editar clientes", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
              //     ),
              //     InkWell(
              //       child: Padding(
              //           padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),

              //         child: Text("Ver mas", style: TextStyle(color: Utils.colorPrimaryBlue)),
              //       ),
              //       onTap: (){},
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelStyle: TextStyle(color: Utils.colorPrimaryBlue),
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    labelColor: Utils.colorPrimaryBlue,
                    // indicatorWeight: 4.0,
                    indicator: CircleTabIndicator(color: Utils.colorPrimaryBlue, radius: 5),
                    // UnderlineTabIndicator(
                    //   borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),

                    //   insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                    // ),
                    
                    tabs: [
                      new Tab(
                        // icon: const Icon(Icons.home),
                        // child: Text('Mensajes'),
                        child: Text('Informacion personal',),
                        
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Trabajo',),
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Referencias',),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: new TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                            child: DraggableScrollbar(
                              controller: _scrollController,
                              // alwaysVisibleScrollThumb: true,
                              // heightScrollThumb: 2,
                              heightScrollThumb: 80.0,
                              // backgroundColor: Utils.colorPrimaryBlue,
                              child: ListView(
                                controller: _scrollController,
                                children: [
                               
                                Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // File file = await FilePicker.getFile();
                                            // IO.File(file.relativePath);
                                            // // base64.decode(file);
                                            // setState(() {
                                            //   _image = file;
                                            // });
                                            _startFilePicker();
                                            // print("Archivo: ${file.name}");
                                            // Blo
                                            // print("ArchivoType: ${file.}");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0, right: 20),
                                            child: Container(
                                              // color: ,
                                              width: 130,
                                              height: 130,
                                              child:  ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Container(
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    widthFactor: 0.75,
                                                    heightFactor: 0.75,
                                                    child: uploadedImage != null ? Image.memory(uploadedImage) : Image(image: AssetImage('images/user.png'), ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        LayoutBuilder(
                                          builder: (context, boxconstraints){
                                            return Container(
                                              width: boxconstraints.maxWidth / 1.2,
                                              child: Wrap(
                                                children: [
                                                  MySubtitle(title: "Datos personales"),
                                                  MyDropdownButton(
                                          medium: 2, 
                                          title: "Tipo Doc.", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Cedula de identidad", "RNC"],
                                          xlarge: 4,
                                        ),
                                        new MyTextFormField(title: "Documento", controller: _txtDocumento, hint: "Documento", medium: 2,),
                                        MyTextFormField(title: "Nombres", controller: _txtNombres, hint: "Nombres", medium: 2, xlarge: 3.7,),
                                        MyTextFormField(title: "Apellidos", controller: _txtApellidos, hint: "Apellidos", medium: 2, xlarge: 3.7,),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        
                                        MyTextFormField(title: "Apodo", controller: _txtApodo, hint: "Apodo", medium: 2, xlarge: 8),
                                        MyDatePicker(title: "Fecha Nacimiento", fecha: _fechaNacimiento, onDateTimeChanged: (newDate) => setState(() => _fechaNacimiento = newDate), medium: 2,),
                                        MyTextFormField(title: "No. Dependientes", controller: _txtNumeroDependientes, hint: "No. Dependientes", medium: 2, xlarge: 6),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Sexo", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Hombre", "Mujer", "Otro..."],
                                          xlarge: 6,
                                        ),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Estado civil", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Soltero", "Casado", "Union libre"],
                                          xlarge: 6,
                                        ),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Nacionalidad", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Dominicano", "Haitiano", "Americano", "Chino", "Japones"],
                                          xlarge: 6,
                                        ),
                                        MySubtitle(title: "Datos direccion"),
                                        MyTextFormField(title: "Direccion", controller: _txtDireccion, hint: "Direccion", medium: 2, xlarge: 3.5),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Ciudad", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Distrito Nacional", "Santo Domingo Este", "Santiago de los Caballeros"],
                                          xlarge: 4,
                                        ),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Provincia", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Santiago", "Santo Domingo", "San Cristobal"],
                                          xlarge: 4,
                                        ),
                                        MyTextFormField(title: "Sector", controller: _txtSector, hint: "Sector", medium: 2,),
                                        MySubtitle(title: "Contacto"),
                                        MyTextFormField(title: "Telefono", controller: _txtTelefeno, hint: "Telefono", medium: 2,),
                                        MyTextFormField(title: "Celular", controller: _txtCelular, hint: "Celular", medium: 2,),
                                        MyTextFormField(title: "Fax", controller: _txtFax, hint: "Fax", medium: 2,),
                                        MySubtitle(title: "Datos vivienda"),
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Vivienda", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Propia", "Alquilada", "Pagando"],
                                          xlarge: 4,
                                        ),
                                        MyTextFormField(title: "Tiempo en residencia", controller: _txtTiempoEnResidencia, hint: "Tiempo en residencia", medium: 2,),
                                        MyTextFormField(title: "Referido por", controller: _txtReferidoPor, hint: "Referido por", medium: 2,),
                                        // Column(children: [
                                        //   Text("Documento", style: TextStyle(color: Colors.red),),
                                        //   Container(
                                        //     child: TextFormField(
                                        //       controller: _txtDocumento,
                                        //         decoration: InputDecoration(
                                        //           labelText: "Docuemnto"
                                        //         ),
                                        //       ),
                                        //   )
                                        // ],)
                                      ],
                                    )
                              ],),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                            child: DraggableScrollbar(
                              controller: _scrollControllerTrabajo,
                              
                              
                              // alwaysVisibleScrollThumb: true,
                              // heightScrollThumb: 2,
                              heightScrollThumb: 80.0,
                              child: ListView(
                                controller: _scrollControllerTrabajo,
                                children: [
                                Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        MySubtitle(title: "Datos de trabajo"),
                                        
                                        MyDropdownButton(
                                          medium: 2, 
                                          title: "Lugar de trabajo", 
                                          onChanged: (data){

                                          }, 
                                          elements: ["Hospital", "Taller", "Constructora", "Banco", ""],
                                          xlarge: 4,
                                        ),
                                        
                                        MyTextFormField(title: "Direccion", controller: _txtDireccionTrabajo, hint: "Direccion", medium: 2, xlarge: 2.9,),
                                        MyTextFormField(title: "Numero", controller: _txtNumeroTrabajo, hint: "Numero", medium: 2, ),
                                        MyTextFormField(title: "Sector", controller: _txtSectorTrabajo, hint: "Sector", medium: 2, ),
                                        MyTextFormField(title: "Ciudad", controller: _txtCiudadTrabajo, hint: "Ciudad", medium: 2, xlarge: 4),
                                        MyTextFormField(title: "Telefono", controller: _txtTelefonoTrabajo, hint: "Telefono", medium: 2, xlarge: 5),
                                        MyTextFormField(title: "Extension", controller: _txtExtensionTrabajo, hint: "Extension", medium: 2, xlarge: 7),
                                        MyTextFormField(title: "Fax", controller: _txtFaxTrabajo, hint: "Fax", medium: 2, xlarge: 5),
                                        MyTextFormField(title: "Puesto/Ocupacion", controller: _txtOcupacionTrabajo, hint: "Puesto/Ocupacion", medium: 2, xlarge: 5),
                                        MyTextFormField(title: "Departamento", controller: _txtDepartamentoTrabajo, hint: "Departamento", medium: 2, xlarge: 4),
                                        MyTextFormField(title: "Supervisor", controller: _txtSupervisorTrabajo, hint: "Supervisor", medium: 2, xlarge: 5),
                                        MyTextFormField(title: "Ingresos", controller: _txtIngresosTrabajo, hint: "Ingresos", medium: 2, xlarge: 5),
                                        MyTextFormField(title: "Otros ingresos", controller: _txtOtrosIngresosTrabajo, hint: "Ingresos", medium: 2, xlarge: 7),
                                        MyDatePicker(title: "Fecha ingreso", fecha: _fechaIngresoTrabajo, onDateTimeChanged: (newDate) => setState(() => _fechaNacimiento = newDate), medium: 2, xlarge: 5,),
                                        
                                        MySubtitle(title: "Datos del negocio"),
                                        MyTextFormField(title: "Nombre", controller: _txtNombreNegocio, hint: "Nombre", medium: 2, xlarge: 3,),
                                        MyTextFormField(title: "Tipo", controller: _txtTipoNegocio, hint: "Tipo", medium: 2, xlarge: 3,),
                                        MyTextFormField(title: "Tiempo Existencia", controller: _txtTiempoExistenciaNegocio, hint: "Tiempo Existencia", medium: 2, xlarge: 3,),
                                        MyTextFormField(title: "Direccion", controller: _txtDireccionNegocio, hint: "Direccion", medium: 2, xlarge: 2,),
                                        MyTextFormField(title: "Rutas de venta", controller: _txtRutasdeventaNegocio, hint: "Rutas de venta", maxLines: null, medium: 2, xlarge: 2,),
                                        
                                      ],
                                    )
                              ],),
                            ),
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: FlatButton(onPressed: _agregarReferencia, child: Text("+ Agregar referencia", style: TextStyle(fontFamily: "Roboto",color: Utils.colorPrimaryBlue, fontWeight: FontWeight.w600)))
                                ),
                              ),
                              StreamBuilder<List<Referencia>>(
                                stream: _streamBuilderReferencia.stream,
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    return _buildTable(snapshot.data);
                                  }
                                  return _buildTable(List<Referencia>());
                                }
                              ),
                            ],
                          )
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
        
      ],),
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
                Center(child: IconButton(icon: Icon(Icons.delete, size: 28,), onPressed: () async {_removerReferencia(b);},)),
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

