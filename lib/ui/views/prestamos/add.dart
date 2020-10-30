import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/services/loanservice.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:rxdart/rxdart.dart';

class PrestamoAddScreen extends StatefulWidget {
  @override
  _PrestamoAddScreenState createState() => _PrestamoAddScreenState();
}

class _PrestamoAddScreenState extends State<PrestamoAddScreen> with TickerProviderStateMixin {
  var _tabController;
  ScrollController _scrollController;
  ScrollController _scrollControllerGarante;
  ScrollController _scrollControllerGastos;
  StreamController<List<Tipo>> _streamControllerTipo;
  var _formKey = GlobalKey<FormState>();
  var _txtCliente = TextEditingController();
  var _focusNodeTxtCliente = FocusNode();
  var _txtMonto = TextEditingController();
  var _txtInteres = TextEditingController();
  var _txtCuotas = TextEditingController();
  var _txtCodigo = TextEditingController();
  var _txtMora = TextEditingController();
  var _txtDiasGracia = TextEditingController();
  bool _aplicarTasaDelPrestamo = false;

  var _txtNombresGarante = TextEditingController();
  var _txtTelefonoGarante = TextEditingController();
  var _txtNumeroIdentificacionGarante = TextEditingController();
  var _txtDireccionGarante = TextEditingController();
  

  var _txtPorcentajeGasto = TextEditingController();
  var _txtImporteGasto = TextEditingController();
  bool _incluirEnElFinanciamiento = false;

  bool _cargando = false;
  List<Tipo> listaTipo;
  List<Caja> listaCaja;
  Cliente _cliente;
  Tipo _tipoAmortizacion;
  Tipo _tipoPlazo;
  Tipo _tipoGasto;
  Caja _caja;
  var _fecha = DateTime.now();
  var _fechaPrimerPago = DateTime.now();
  
  _create(){

  }

  _aplicarTasaDelPrestamoChanged(data){
    if(_txtInteres.text.isNotEmpty){
      _txtMora.text = _txtInteres.text;
      setState(() => _aplicarTasaDelPrestamo = data);
    }
  }
  _incluirEnElFinanciamientoChanged(data){
      setState(() => _incluirEnElFinanciamiento = data);
  }

  _init() async {
    try {
      setState(() => _cargando = true);
      var parsed = await LoanService.index(context: context);
      print("_init: $parsed");
      listaTipo = (parsed["tipos"] != null) ? parsed["tipos"].map<Tipo>((json) => Tipo.fromMap(json)).toList() : List<Tipo>();
      listaCaja = (parsed["cajas"] != null) ? parsed["cajas"].map<Caja>((json) => Caja.fromMap(json)).toList() : List<Caja>();
      _streamControllerTipo.add(listaTipo);
      for(Tipo c in listaTipo){
        print("Nombre: ${c.descripcion}");
      }
    //  _streamController.add(lista);
      setState(() => _cargando = false);
    } catch (e) {
      print("\prestamos\add _init: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _showModalGarantia(){
    String tipoGarantia = "Vehiculo";
    Tipo _tipoGarantia = Tipo(descripcion: "Vehiculo");
    Tipo _condicionGarantia;
    Tipo _tipoVehiculo;
    var _txtMatricula = TextEditingController();
    var _txtMarca = TextEditingController();
    var _txtModelo = TextEditingController();
    var _txtTasacion = TextEditingController();
    var _txtColor = TextEditingController();
    var _txtNumeroPuertas = TextEditingController();
    var _txtCilindros = TextEditingController();
    var _txtNumeroPasajeros = TextEditingController();
    var _txtFuerzaMotriz = TextEditingController();
    var _txtCapacidadCarga = TextEditingController();
    var _txtPlacaAnterior = TextEditingController();
    var _anoFabricacion = DateTime.now();
    var _fechaExpedicion = DateTime.now();
    showDialog(
      context: context,
      builder: (context){
        _formVehiculo(){
          return Wrap(children: [
            MySubtitle(title: "Basico"),
            MyTextFormField(
              controller: _txtMatricula,
              title: "No. Matricula",
              medium: 5,
            ),
            MyTextFormField(
              controller: _txtMarca,
              title: "Marca",
              hint: "Marca",
              medium: 3.5,
            ),
            
            MyTextFormField(
              controller: _txtModelo,
              title: "Modelo",
              hint: "Modelo",
              medium: 3.5,
            ),
            MyTextFormField(
              controller: _txtTasacion,
              title: "Tasacion",
              hint: "Tasacion",
              medium: 5,
            ),
            MyTextFormField(
              controller: _txtColor,
              title: "Color",
              hint: "Color",
              medium: 5,
              xlarge: 5,
            ),
            MyTextFormField(
              controller: _txtNumeroPuertas,
              title: "No. Puertas",
              hint: "No. Puertas",
              medium: 5,
              xlarge: 5,
            ),
            MyDropdownButton(
              title: "Condicion",
              elements: listaTipo.where((element) => element.renglon == "condicionGarantia").map((e) => e.descripcion).toList(),
              onChanged: (data){
                if(data != null)
                  setState(() => _condicionGarantia = listaTipo.firstWhere((element) => element.descripcion == data && element.renglon == "condicionGarantia"));
              },
              medium: 4,
            ),
            MySubtitle(title: "Avanzado",),
            MyTextFormField(
              controller: _txtCilindros,
              title: "Cilindros",
              hint: "Cilindros",
              medium: 4.1,
            ),
            MyTextFormField(
              controller: _txtNumeroPasajeros,
              title: "No. Pasajeros",
              hint: "No. Pasajeros",
              medium: 4.1,
            ),
            
             MyDropdownButton(
              title: "Tipo",
              elements: listaTipo.where((element) => element.renglon == "tipoVehiculo").map((e) => e.descripcion).toList(),
              onChanged: (data){
                if(data != null)
                  setState(() => _tipoVehiculo = listaTipo.firstWhere((element) => element.descripcion == data && element.renglon == "tipoVehiculo"));
              },
              medium: 4,
            ),
            MyTextFormField(
              controller: _txtFuerzaMotriz,
              title: "Fuerza motriz (HP/CC)",
              hint: "Fuerza motriz (HP/CC)",
              medium: 4,
            ),
            MyTextFormField(
              controller: _txtCapacidadCarga,
              title: "Capacidad carga (Ton.)",
              hint: "Capacidad carga (Ton.)",
              medium: 3.4,
            ),
            MyTextFormField(
              controller: _txtPlacaAnterior,
              title: "Placa anterior",
              hint: "Placa anterior",
              medium: 5,
            ),
            MyDatePicker(title: "Ano fabricacion", fecha: _anoFabricacion, onDateTimeChanged: (data){setState(() => _anoFabricacion = data);}, medium: 4,),
            MyDatePicker(title: "Fecha expedicion", fecha: _fechaExpedicion, onDateTimeChanged: (data){setState(() => _fechaExpedicion = data);}, medium: 4,),
           
          ],);
        }

        _formGarantiaNormal(){
          return Wrap(children: [

          ],);
        }
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Agregar garantia", style: TextStyle(fontWeight: FontWeight.w700)),
              content: Container(
                width: (ScreenSize.isSmall(MediaQuery.of(context).size.width) == false) ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Wrap(children: [
                    MyDropdownButton(
                      title: "Tipo garantia",
                      elements: listaTipo.where((element) => element.renglon == "garantia").map((e) => e.descripcion).toList(),
                      onChanged: (data){
                        if(data != null)
                          setState(() => _tipoGarantia = listaTipo.firstWhere((element) => element.descripcion == data && element.renglon == "garantia"));
                      },
                    ),
                    // MySubtitle(title: "Garantia")
                    (_tipoGarantia.descripcion == "Vehiculo")
                    ?
                    _formVehiculo()
                    :
                    _formGarantiaNormal()
                  ],)
                ),
              ),
              actions: [
                FlatButton(
                  child: Text("Cancelar", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey)),
                  onPressed: (){},
                ),
                SizedBox(width: 10),
                myButton(function: (){}, text: "Agregar")
              ],
            );
          }
        );
      }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _streamControllerTipo = BehaviorSubject();
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      prestamos: true,
      body: [
        MyHeader(title: "Prestamo", subtitle: "Agregue todos los prestamos con sus respectivas garantias, garantes y cobradores.", function: _create, actionFuncion: "Agregar",),
        Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelStyle: TextStyle(color: Utils.colorPrimaryBlue, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    labelColor: Colors.black,
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
                        child: Text('Prestamo',),

                        
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Garante y Cobrador',),
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Gastos',),
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Garantias',),
                      ),
                      // new Tab(
                      //   // icon: const Icon(Icons.my_location),
                      //   child: Text('Referencias',),
                      // ),
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
                          
                          StreamBuilder<List<Tipo>>(
                            stream: _streamControllerTipo.stream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData == false)
                                return Center(child: CircularProgressIndicator(),);

                              return Padding(
                                padding: const EdgeInsets.only(left: 18.0, top: 10.0),
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
                                        children: [
                                          MySearchField(
                                            // labelText: "Cliente",
                                            title: "Cliente *",
                                            controller: _txtCliente,
                                            focusNode: _focusNodeTxtCliente,
                                            hint: "Buscar cliente",
                                            onSelected: (cliente){
                                              if(cliente != null)
                                                _cliente = cliente;
                                            },
                                            xlarge: 3,
                                          ),
                                          MyDropdownButton(
                                            xlarge: 3,
                                            title: "Amortizacion *",
                                            elements: listaTipo.where((element) => element.renglon == "amortizacion").toList().map<String>((e) => e.descripcion).toList(),
                                            onChanged: (data){
                                              _tipoAmortizacion = listaTipo.firstWhere((element) => element.descripcion == data);
                                            },
                                          ),
                                          MyDropdownButton(
                                            xlarge: 3,
                                            title: "Plazo *",
                                            elements: listaTipo.where((element) => element.renglon == "plazo").toList().map<String>((e) => e.descripcion).toList(),
                                            onChanged: (data){
                                              _tipoPlazo = listaTipo.firstWhere((element) => element.descripcion == data);
                                            },
                                          ),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "Monto a prestar *",
                                            controller: _txtMonto,
                                            hint: "Monto",
                                            isRequired: true,
                                            xlarge: 3,
                                          ),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "% interes *",
                                            controller: _txtInteres,
                                            hint: "% interes",
                                            isRequired: true,
                                            xlarge: 3,
                                          ),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "# Cuotas *",
                                            controller: _txtCuotas,
                                            hint: "Cuotas",
                                            isRequired: true,
                                            xlarge: 3,
                                          ),
                                          MyDatePicker(
                                            title: "Fecha",
                                            initialEntryMode: DatePickerEntryMode.calendar,
                                            onDateTimeChanged: (data){
                                              _fecha = data;
                                            },
                                            xlarge: 4,
                                          ),
                                          MyDatePicker(
                                            title: "Fecha primer pago",
                                            initialEntryMode: DatePickerEntryMode.calendar,
                                            onDateTimeChanged: (data){
                                              _fechaPrimerPago = data;
                                            },
                                            xlarge: 4,
                                          ),
                                          MyDropdownButton(
                                            xlarge: 4,
                                            title: "Caja *",
                                            elements: listaCaja.map<String>((e) => e.descripcion).toList(),
                                            onChanged: (data){
                                              _caja = listaCaja.firstWhere((element) => element.descripcion == data);
                                            },
                                          ),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "Codigo unico",
                                            controller: _txtCodigo,
                                            hint: "Codigo unico",
                                            xlarge: 4,
                                          ),

                                          MySubtitle(title: "Mora"),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "% mora",
                                            controller: _txtMora,
                                            hint: "% mora",
                                            enabled: !_aplicarTasaDelPrestamo,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 25.0),
                                            child: MyCheckBox(title: "Aplicar tasa del prestamo", value: _aplicarTasaDelPrestamo, onChanged: _aplicarTasaDelPrestamoChanged,),
                                          ),
                                          MyTextFormField(
                                            // labelText: "Cliente",
                                            title: "Dias de gracia",
                                            controller: _txtDiasGracia,
                                            hint: "Dias de gracia",
                                          ),
                                        ],
                                      ),
                                      
                                   
                                  ],),
                                ),
                              );
                            }
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                            child: DraggableScrollbar(
                              controller: _scrollController,
                              // alwaysVisibleScrollThumb: true,
                              // heightScrollThumb: 2,
                              heightScrollThumb: 80.0,
                              // backgroundColor: Utils.colorPrimaryBlue,
                              child: ListView(
                                controller: _scrollControllerGarante,
                                children: [
                                  Wrap(
                                    children: [
                                        MySubtitle(title: "Garante"),
                                        MyTextFormField(
                                          // labelText: "Cliente",
                                          title: "Nombres",
                                          controller: _txtNombresGarante,
                                          hint: "Nombres",
                                          xlarge: 4,
                                        ),
                                        MyTextFormField(
                                          // labelText: "Cliente",
                                          title: "Numero identificacion",
                                          controller: _txtNumeroIdentificacionGarante,
                                          hint: "Numero identificacion",
                                          xlarge: 5,
                                        ),
                                        MyTextFormField(
                                          // labelText: "Cliente",
                                          title: "Telefono",
                                          controller: _txtTelefonoGarante,
                                          hint: "Telefono",
                                          xlarge: 5,
                                        ),
                                        MyTextFormField(
                                          // labelText: "Cliente",
                                          title: "Direccion",
                                          controller: _txtDireccionGarante,
                                          hint: "Direccion",
                                          xlarge: 3,
                                        ),

                                        MySubtitle(title: "Cobrador"),
                                        MyDropdownButton(
                                            xlarge: 4,
                                            title: "Cobrador *",
                                            elements: ["Ninguno"],
                                            onChanged: (data){
                                              // _caja = listaCaja.firstWhere((element) => element.descripcion == data);
                                            },
                                          ),
                                    ],
                                  )
                               
                              ],),
                            ),
                          ),
                          
                          StreamBuilder<List<Tipo>>(
                            stream: _streamControllerTipo.stream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData == false)
                                return CircularProgressIndicator();

                              return Padding(
                                padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                                child: DraggableScrollbar(
                                  controller: _scrollControllerGastos,
                                  // alwaysVisibleScrollThumb: true,
                                  // heightScrollThumb: 2,
                                  heightScrollThumb: 80.0,
                                  // backgroundColor: Utils.colorPrimaryBlue,
                                  child: ListView(
                                    controller: _scrollController,
                                    children: [
                                      Wrap(
                                        children: [
                                            // MySubtitle(title: "Garante"),
                                            // MyDropdownButton(onChanged: null, elements: ["Jean"], title: "Culo",)
                                            MyDropdownButton(
                                                xlarge: 3,
                                                title: "Tipo de gasto",
                                                elements: listaTipo.where((element) => element.renglon == "gastoPrestamo").toList().map<String>((e) => e.descripcion).toList(),
                                                onChanged: (data){
                                                  _tipoGasto = listaTipo.firstWhere((element) => element.descripcion == data);
                                                },
                                              ),
                                            MyTextFormField(
                                              // labelText: "Cliente",
                                              title: "Porcentaje",
                                              controller: _txtPorcentajeGasto,
                                              hint: "Porcentaje",
                                              xlarge: 4,
                                            ),
                                            MyTextFormField(
                                              // labelText: "Cliente",
                                              title: "Importe",
                                              controller: _txtImporteGasto,
                                              hint: "Importe",
                                              xlarge: 4,
                                            ),
                                            
                                            Padding(
                                              padding: const EdgeInsets.only(top: 25.0),
                                              child: MyCheckBox(title: "Incluir en el financiamiento", value: _incluirEnElFinanciamiento, onChanged: _incluirEnElFinanciamientoChanged,),
                                            )
                                            
                                        ],
                                      )
                                   
                                  ],),
                                ),
                              );
                            }
                          ),
                          
                          StreamBuilder<List<Tipo>>(
                            stream: _streamControllerTipo.stream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData == false)
                                return CircularProgressIndicator();

                              return Padding(
                                padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                                child: DraggableScrollbar(
                                  controller: _scrollControllerGastos,
                                  // alwaysVisibleScrollThumb: true,
                                  // heightScrollThumb: 2,
                                  heightScrollThumb: 80.0,
                                  // backgroundColor: Utils.colorPrimaryBlue,
                                  child: ListView(
                                    controller: _scrollController,
                                    children: [
                                      Wrap(
                                        children: [
                                            // MySubtitle(title: "Garante"),
                                            // MyDropdownButton(onChanged: null, elements: ["Jean"], title: "Culo",)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 28.0),
                                                  child: FlatButton(child: Text("Agregar garantia a este prestamo", style: TextStyle(letterSpacing: 0.3, color: Utils.fromHex("#2579e8"), fontWeight: FontWeight.w600, fontFamily: "Roboto" )), onPressed: (){_showModalGarantia();}),
                                                ),
                                                // myButton(function: (){}, text: "Agregar garantia", color: Colors.green)
                                            ],
                                            )
                                            
                                        ],
                                      )
                                   
                                  ],),
                                ),
                              );
                            }
                          ),
                          
                        ],
                      ),
                ),
              ),
             
      ] 
    );
  }
}