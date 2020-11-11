import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/configuracionprestamo.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/models/garantia.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/services/loanservice.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mycheckbox.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mysidedropdownbutton.dart';
import 'package:prestamo/ui/widgets/mysidetextformfield.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:rxdart/rxdart.dart';

class PrestamoAddScreen extends StatefulWidget {
  @override
  _PrestamoAddScreenState createState() => _PrestamoAddScreenState();
}

class _PrestamoAddScreenState extends State<PrestamoAddScreen> with TickerProviderStateMixin {
  var _tabController;
  List<String> listaTab = ["Prestamo", "Garante y cobrador", "Gasto", "Garantia", "Desembolso"];
  ScrollController _scrollController;
  ScrollController _scrollControllerGarante;
  ScrollController _scrollControllerGastos;
  ScrollController _scrollControllerDesembolso;
  StreamController<List<Tipo>> _streamControllerTipo;
  StreamController<List<Garantia>> _streamControllerGarantia;
  StreamController<List<Cuenta>> _streamControllerCuenta;
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

  var _txtNumeroCheque = TextEditingController();
  var _txtCuentaDestino = TextEditingController();

  bool _cargando = false;
  List<Tipo> listaTipo;
  List<Caja> listaCaja;
  List<Garantia> listaGarantia = List();
  List<Banco> listaBanco = List();
  List<Cuenta> listaCuenta = List();
  List<Cuenta> listaCuentaFiltrada = List();
  Cliente _cliente;
  Tipo _tipoAmortizacion;
  Tipo _tipoPlazo;
  Tipo _tipoGasto;
  Tipo _tipoDesembolso;
  Tipo _tipoGarantia;
  Tipo _tipoCondicionGarantia;
  Tipo _tipoTipoVehiculoGarantia;
  Caja _caja;
  Cuenta _cuenta;
  Banco _banco;
  Banco _bancoDestino;
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
      // setState(() => _cargando = true);
      var parsed = await LoanService.index(context: context);
      print("_init: $parsed");
      listaTipo = (parsed["tipos"] != null) ? parsed["tipos"].map<Tipo>((json) => Tipo.fromMap(json)).toList() : List<Tipo>();
      listaCaja = (parsed["cajas"] != null) ? parsed["cajas"].map<Caja>((json) => Caja.fromMap(json)).toList() : List<Caja>();
      listaBanco = (parsed["bancos"] != null) ? parsed["bancos"].map<Banco>((json) => Banco.fromMap(json)).toList() : List<Banco>();
      listaCuenta = (parsed["cuentas"] != null) ? parsed["cuentas"].map<Cuenta>((json) => Cuenta.fromMap(json)).toList() : List<Cuenta>();
      _updateTab(ConfiguracionPrestamo.fromMap(parsed["configuracionPrestamo"]));
      _selectComboFirstValue();
      _streamControllerTipo.add(listaTipo);
      _streamControllerCuenta.add(listaCuenta);
      for(Tipo c in listaTipo){
        print("Nombre: ${c.descripcion}");
      }
    //  _streamController.add(lista);
      // setState(() => _cargando = false);
    } catch (e) {
      print("\prestamos\add _init: ${e.toString()}");
      // setState(() => _cargando = false);
    }
  }

  _selectComboFirstValue(){
    String _initialValueDesembolso;
    var listaDesembolso = listaTipo.where((element) => element.renglon == "desembolso").toList();
    var listaGastoPrestamo = listaTipo.where((element) => element.renglon == "gastoPrestamo").toList();
    var listaGarantia = listaTipo.where((element) => element.renglon == "garantia").toList();
    var listaCondicionGarantia = listaTipo.where((element) => element.renglon == "condicionGarantia").toList();
    var listaTipoVehiculoGarantia = listaTipo.where((element) => element.renglon == "tipoVehiculo").toList();
    var listaPlazo = listaTipo.where((element) => element.renglon == "plazo").toList();
    var listaAmortizacion = listaTipo.where((element) => element.renglon == "amortizacion").toList();
    if(listaDesembolso.length > 0){
      _tipoDesembolso = listaDesembolso.firstWhere((element) => element.descripcion == "Efectivo");
      _initialValueDesembolso = _tipoDesembolso.descripcion;
    }
    if(listaGastoPrestamo.length > 0){
      _tipoGasto = listaGastoPrestamo[0];
    }
    if(listaGarantia.length > 0){
      _tipoGarantia = listaGarantia[0];
    }
    if(listaCondicionGarantia.length > 0){
      _tipoCondicionGarantia = listaCondicionGarantia[0];
    }
    if(listaTipoVehiculoGarantia.length > 0){
      _tipoTipoVehiculoGarantia = listaTipoVehiculoGarantia[0];
    }
    if(listaPlazo.length > 0){
      _tipoPlazo = listaPlazo[0];
    }
    if(listaAmortizacion.length > 0){
      _tipoAmortizacion = listaAmortizacion[0];
    }
    _cbxBancoOnChanged();
    _cbxBancoDestinoOnChanged();
    // if(listaBanco.length > 0){
    //   _banco = listaBanco[0];
    // }
    // if(listaBanco.length > 0){
    //   var _listaCuenta = listaCuenta.where((element) => element.idBanco == _banco.id).toList();
    //   if(_listaCuenta.length > 0)
    //     _cuenta = _listaCuenta[0];
    // }
  }

  _cbxBancoOnChanged([String data]){
    if(listaBanco.length > 0){
      if(data == null){
        setState(() {
          _banco = listaBanco[0];
          _filtrarListaCuenta();
        });
      }
      else{
        int idx = listaBanco.indexWhere((element) => element.descripcion == data);
        if(idx != -1){
          setState(() {
            _banco = listaBanco[idx];
            _filtrarListaCuenta();
          });
        }
      }
    }
  }
  _cbxBancoDestinoOnChanged([String data]){
    if(listaBanco.length > 0){
      if(data == null){
        setState(() {
          _bancoDestino = listaBanco[0];
        });
      }
      else{
        int idx = listaBanco.indexWhere((element) => element.descripcion == data);
        if(idx != -1){
          setState(() {
            _bancoDestino = listaBanco[idx];
          });
        }
      }
    }
  }

  _cbxCuentaOnChanged([String data]){
    if(listaCuenta.length > 0){
      if(data == null)
        _cuenta = listaCuenta[0];
      else{
        int idx = listaCuenta.indexWhere((element) => element.descripcion == data);
        if(idx != -1){
          _cuenta = listaCuenta[idx];
        }
      }
    }
  }

  _filtrarListaCuenta(){
    if(listaCuenta.length > 0 && _banco != null){
      _streamControllerCuenta.add(listaCuenta.where((element) => element.idBanco == _banco.id).toList());

    }
  }

  _showModalGarantia({int indexGarantia}){
    String tipoGarantia = "Vehiculo";
    Tipo _tipoGarantia = Tipo(descripcion: "Vehiculo");
    Tipo _condicionGarantia;
    Tipo _tipoVehiculo = listaTipo.firstWhere((element) => element.renglon == "tipoVehiculo");
    var _txtMatricula = TextEditingController();
    var _txtMarca = TextEditingController();
    var _txtModelo = TextEditingController();
    var _txtTasacion = TextEditingController();
    var _txtColor = TextEditingController();
    var _txtNumeroPuertas = TextEditingController();
    var _txtCilindros = TextEditingController();
    var _txtNumeroPasajeros = TextEditingController();
    var _txtMotorOSerie = TextEditingController();
    var _txtFuerzaMotriz = TextEditingController();
    var _txtCapacidadCarga = TextEditingController();
    var _txtPlaca = TextEditingController();
    var _txtPlacaAnterior = TextEditingController();
    var _txtDescripcion = TextEditingController();
    var _txtChasis = TextEditingController();
    var _anoFabricacion = DateTime.now();
    var _fechaExpedicion = DateTime.now();

    if(indexGarantia != null){
      if(listaGarantia[indexGarantia].tipoGarantia.descripcion == "Vehiculo"){
      _tipoGarantia = listaGarantia[indexGarantia].tipo;
     _condicionGarantia = listaGarantia[indexGarantia].condicion;
     _tipoVehiculo = listaGarantia[indexGarantia].tipo;
     _txtMatricula.text = listaGarantia[indexGarantia].matricula;
     _txtMarca.text = listaGarantia[indexGarantia].marca;
     _txtModelo.text = listaGarantia[indexGarantia].modelo;
     _txtTasacion.text = listaGarantia[indexGarantia].tasacion.toString();
     _txtColor.text = listaGarantia[indexGarantia].color;
     _txtNumeroPuertas.text = listaGarantia[indexGarantia].numeroPuertas.toString();
     _txtCilindros.text = listaGarantia[indexGarantia].cilindros.toString();
     _txtNumeroPasajeros.text = listaGarantia[indexGarantia].numeroPasajeros.toString();
     _txtMotorOSerie.text = listaGarantia[indexGarantia].motorOSerie;
     _txtFuerzaMotriz.text = listaGarantia[indexGarantia].fuerzaMotriz.toString();
     _txtCapacidadCarga.text = listaGarantia[indexGarantia].capacidadCarga.toString();
     _txtPlaca.text = listaGarantia[indexGarantia].placa;
     _txtPlacaAnterior.text = listaGarantia[indexGarantia].placaAnterior;
     _txtDescripcion.text = listaGarantia[indexGarantia].descripcion;
     _txtChasis.text = listaGarantia[indexGarantia].chasis;
     _anoFabricacion = listaGarantia[indexGarantia].anoFabricacion;
     _fechaExpedicion = listaGarantia[indexGarantia].fechaExpedicion;
      }else{
        _txtDescripcion.text = listaGarantia[indexGarantia].descripcion;
        _txtTasacion.text = listaGarantia[indexGarantia].tasacion.toString();
      }
    }
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
              medium: 3.6,
            ),
            MyDropdownButton(
              title: "Tipo",
              elements: listaTipo.where((element) => element.renglon == "tipoVehiculo").map((e) => e.descripcion).toList(),
              onChanged: (data){
                if(data != null)
                  setState(() => _tipoVehiculo = listaTipo.firstWhere((element) => element.descripcion == data && element.renglon == "tipoVehiculo"));
              },
              medium: 3.5,
            ),
            MySubtitle(title: "Avanzado",),
            MyTextFormField(
              controller: _txtCilindros,
              title: "Cilindros",
              hint: "Cilindros",
              medium: 4.1,
            ),
            MyTextFormField(
              controller: _txtChasis,
              title: "Chasis",
              hint: "Chasis",
              medium: 4,
            ),
            MyTextFormField(
              controller: _txtNumeroPasajeros,
              title: "No. Pasajeros",
              hint: "No. Pasajeros",
              medium: 4.1,
            ),
            
            MyTextFormField(
              controller: _txtMotorOSerie,
              title: "Motor o serie",
              hint: "Motor o serie",
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
              controller: _txtPlaca,
              title: "Placa",
              hint: "Placa",
              medium: 5,
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
            MyTextFormField(
              controller: _txtTasacion,
              title: "Valor",
              hint: "Valor",
              medium: 2,
              xlarge: 5,
            ),
            MyTextFormField(
              controller: _txtDescripcion,
              title: "Descripcion",
              hint: "Descripcion",
              medium: 1,
              xlarge: 5,
              maxLines: 5,
            ),
          ],);
        }

        _agregarGarantia(){
          print("_agregarGarantia ${_tipoGarantia.toJson()}");
          if(_tipoGarantia.descripcion == "Vehiculo"){
            _txtDescripcion.text = "UN VEHICULO MARCA ${_txtMarca.text}, MODELO ${_txtModelo.text}, TASADO EN ${_txtTasacion.text}, TIPO ${_tipoVehiculo.descripcion}, ANO DE FABRICACION ${_anoFabricacion.year}, COLOR ${_txtColor.text}, MOTOR O NO. DE SERIE ${_txtMotorOSerie.text}, CAPACIDAD PARA ${_txtNumeroPasajeros.text} PASAJEROS, FUERZA MOTRIZ ${_txtFuerzaMotriz.text}, CAPACIDAD DE CARGA ${_txtCapacidadCarga.text} (TON.), CILINDROS ${_txtCilindros.text}, NO. DE PUERTAS ${_txtNumeroPuertas.text}";
            if(indexGarantia != null){
              print("Dentro garantiaaaaaa");
              listaGarantia[indexGarantia].descripcion = _txtDescripcion.text; 
              listaGarantia[indexGarantia].tasacion = Utils.toDouble(_txtTasacion.text);
              listaGarantia[indexGarantia].matricula = _txtMatricula.text;
              listaGarantia[indexGarantia].marca = _txtMarca.text;
              listaGarantia[indexGarantia].modelo = _txtModelo.text;
              listaGarantia[indexGarantia].chasis = _txtChasis.text;
              listaGarantia[indexGarantia].placa = _txtPlaca.text;
              listaGarantia[indexGarantia].placaAnterior = _txtPlacaAnterior.text;
              listaGarantia[indexGarantia].anoFabricacion = _anoFabricacion;
              listaGarantia[indexGarantia].fechaExpedicion = _fechaExpedicion;
              listaGarantia[indexGarantia].motorOSerie = _txtMotorOSerie.text;
              listaGarantia[indexGarantia].cilindros = Utils.toInt(_txtCilindros.text);
              listaGarantia[indexGarantia].color = _txtColor.text;
              listaGarantia[indexGarantia].numeroPasajeros = Utils.toInt(_txtNumeroPasajeros.text);
              listaGarantia[indexGarantia].tipo = _tipoVehiculo;
              listaGarantia[indexGarantia].condicion = _condicionGarantia;
              listaGarantia[indexGarantia].numeroPuertas = Utils.toInt(_txtNumeroPuertas.text);
              listaGarantia[indexGarantia].fuerzaMotriz = Utils.toInt(_txtFuerzaMotriz.text);
              listaGarantia[indexGarantia].capacidadCarga = Utils.toInt(_txtCapacidadCarga.text);
            }else{
              Garantia _garantia = Garantia(
              descripcion: _txtDescripcion.text, 
              tasacion: Utils.toDouble(_txtTasacion.text),
              matricula: _txtMatricula.text,
              marca: _txtMarca.text,
              modelo: _txtModelo.text,
              chasis: _txtChasis.text,
              placa: _txtPlaca.text,
              placaAnterior: _txtPlacaAnterior.text,
              anoFabricacion: _anoFabricacion,
              fechaExpedicion: _fechaExpedicion,
              motorOSerie: _txtMotorOSerie.text,
              cilindros: Utils.toInt(_txtCilindros.text),
              color: _txtColor.text,
              numeroPasajeros: Utils.toInt(_txtNumeroPasajeros.text),
              tipo: _tipoVehiculo,
              condicion: _condicionGarantia,
              numeroPuertas: Utils.toInt(_txtNumeroPuertas.text),
              fuerzaMotriz: Utils.toInt(_txtFuerzaMotriz.text),
              capacidadCarga: Utils.toInt(_txtCapacidadCarga.text),
            );
            listaGarantia.add(_garantia);
            }
             _streamControllerGarantia.add(listaGarantia);
            Navigator.pop(context);
          }else{
            if(_txtDescripcion.text.isNotEmpty){
              int indexGarantia = listaGarantia.indexWhere((element) => element.descripcion == _txtDescripcion.text);
              if(indexGarantia != null){
                listaGarantia[indexGarantia].descripcion = _txtDescripcion.text; 
                listaGarantia[indexGarantia].tasacion = Utils.toDouble(_txtTasacion.text); 
              }else{
                listaGarantia.add(Garantia(descripcion: _txtDescripcion.text, tasacion: Utils.toDouble(_txtTasacion.text)));
              }
              _streamControllerGarantia.add(listaGarantia);
              Navigator.pop(context);
            }
          }
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
                myButton(function: (){_agregarGarantia();}, text: "Agregar")
              ],
            );
          }
        );
      }
    );
  }

  _eliminarGarantia(Garantia garantia){
    listaGarantia.remove(garantia);
    _streamControllerGarantia.add(listaGarantia);
  }

  Widget _buildDataTable(List<Garantia> garantias){
    if(garantias == null)
      return SizedBox();
    if(garantias.length == 0)
      return SizedBox();
    return SingleChildScrollView(

        child: DataTable(
          showCheckboxColumn: false,
        columns: [
          // DataColumn(label: Text("#", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Descripcion", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Tasacion", style: TextStyle(fontWeight: FontWeight.w700),)), 
          DataColumn(label: Text("Eliminar", style: TextStyle(fontWeight: FontWeight.w700),)), 
        ], 
        rows: garantias.map((e) => 
          DataRow(
            onSelectChanged: (selected){
              // _update(e);
            },
          cells: [
            // DataCell(Text(e.id.toString())
            // ), 
            DataCell(Text("${e.descripcion.length > 30 ? e.descripcion.substring(0, 30) + '...' : e.descripcion}")
            ), 
            DataCell(Text("${e.tasacion}")
            ), 
            DataCell(
              IconButton(icon: Icon(Icons.delete), onPressed: (){_eliminarGarantia(e);})
            )
          ]
        )
        ).toList()
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _streamControllerTipo = BehaviorSubject();
    _streamControllerGarantia = BehaviorSubject();
    _streamControllerCuenta = BehaviorSubject();
    _init();
    super.initState();
  }

  _getTabView(String tab){
    if(tab == "Garante y cobrador")
      return _garanteScreen();
    else if(tab == "Gasto")
      return _gastoScreen();
    else if(tab == "Garantia")
      return _garantiaScreen();
    else if(tab == "Desembolso")
      return _desembolsoScreen();
    else
      return _prestamoScreen();
  }
  _screen(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
            child: new TabBar(
              onTap: (index){
                if(index == 1){
                  // setState(() => _tabController.index = _tabController.previousIndex);
                }
                print("TabBar onTap: $index");
              },
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
              
              tabs: listaTab.map((e) => Tab(child: Text(e),)).toList()
              // [
              //   AbsorbPointer(
              //     absorbing: false,
              //     child: Tab(
              //       // icon: const Icon(Icons.home),
              //       // child: Text('Mensajes'),
              //       child: Text('Prestamo',),

                    
              //     ),
              //   ),
              //   new Tab(
              //     // icon: const Icon(Icons.my_location),
              //     child: Text('Garante y Cobrador',),
              //   ),
              //   new Tab(
              //     // icon: const Icon(Icons.my_location),
              //     child: Text('Gastos',),
              //   ),
              //   new Tab(
              //     // icon: const Icon(Icons.my_location),
              //     child: Text('Garantias',),
              //   ),
              //   // new Tab(
              //   //   // icon: const Icon(Icons.my_location),
              //   //   child: Text('Referencias',),
              //   // ),
              // ],
            ),
          ),
        ),
        Expanded(
                child: Form(
                  key: _formKey,
                  child: new TabBarView(
                        controller: _tabController,
                        children: listaTab.map<Widget>((e) => _getTabView(e)).toList()
                        // <Widget>[
                          
                        //   _prestamoScreen(),
                        //   _garanteScreen(),
                        //   _gastoScreen(),
                        //   _garantiaScreen()
                          
                          
                        // ],
                      ),
                ),
              ),
      ],
    );
  }

  _prestamoScreen(){
    return DraggableScrollbar(
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
          );
        
    // return StreamBuilder<List<Tipo>>(
    //   stream: _streamControllerTipo.stream,
    //   builder: (context, snapshot) {
    //     if(snapshot.hasData == false)
    //       return Center(child: CircularProgressIndicator(),);

    //     return Padding(
    //       padding: const EdgeInsets.only(left: 18.0, top: 10.0),
    //       child: DraggableScrollbar(
    //         controller: _scrollController,
    //         // alwaysVisibleScrollThumb: true,
    //         // heightScrollThumb: 2,
    //         heightScrollThumb: 80.0,
    //         // backgroundColor: Utils.colorPrimaryBlue,
    //         child: ListView(
    //           controller: _scrollController,
    //           children: [
    //             Wrap(
    //               children: [
    //                 MySearchField(
    //                   // labelText: "Cliente",
    //                   title: "Cliente *",
    //                   controller: _txtCliente,
    //                   focusNode: _focusNodeTxtCliente,
    //                   hint: "Buscar cliente",
    //                   onSelected: (cliente){
    //                     if(cliente != null)
    //                       _cliente = cliente;
    //                   },
    //                   xlarge: 3,
    //                 ),
    //                 MyDropdownButton(
    //                   xlarge: 3,
    //                   title: "Amortizacion *",
    //                   elements: listaTipo.where((element) => element.renglon == "amortizacion").toList().map<String>((e) => e.descripcion).toList(),
    //                   onChanged: (data){
    //                     _tipoAmortizacion = listaTipo.firstWhere((element) => element.descripcion == data);
    //                   },
    //                 ),
    //                 MyDropdownButton(
    //                   xlarge: 3,
    //                   title: "Plazo *",
    //                   elements: listaTipo.where((element) => element.renglon == "plazo").toList().map<String>((e) => e.descripcion).toList(),
    //                   onChanged: (data){
    //                     _tipoPlazo = listaTipo.firstWhere((element) => element.descripcion == data);
    //                   },
    //                 ),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "Monto a prestar *",
    //                   controller: _txtMonto,
    //                   hint: "Monto",
    //                   isRequired: true,
    //                   xlarge: 3,
    //                 ),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "% interes *",
    //                   controller: _txtInteres,
    //                   hint: "% interes",
    //                   isRequired: true,
    //                   xlarge: 3,
    //                 ),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "# Cuotas *",
    //                   controller: _txtCuotas,
    //                   hint: "Cuotas",
    //                   isRequired: true,
    //                   xlarge: 3,
    //                 ),
    //                 MyDatePicker(
    //                   title: "Fecha",
    //                   initialEntryMode: DatePickerEntryMode.calendar,
    //                   onDateTimeChanged: (data){
    //                     _fecha = data;
    //                   },
    //                   xlarge: 4,
    //                 ),
    //                 MyDatePicker(
    //                   title: "Fecha primer pago",
    //                   initialEntryMode: DatePickerEntryMode.calendar,
    //                   onDateTimeChanged: (data){
    //                     _fechaPrimerPago = data;
    //                   },
    //                   xlarge: 4,
    //                 ),
    //                 MyDropdownButton(
    //                   xlarge: 4,
    //                   title: "Caja *",
    //                   elements: listaCaja.map<String>((e) => e.descripcion).toList(),
    //                   onChanged: (data){
    //                     _caja = listaCaja.firstWhere((element) => element.descripcion == data);
    //                   },
    //                 ),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "Codigo unico",
    //                   controller: _txtCodigo,
    //                   hint: "Codigo unico",
    //                   xlarge: 4,
    //                 ),

    //                 MySubtitle(title: "Mora"),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "% mora",
    //                   controller: _txtMora,
    //                   hint: "% mora",
    //                   enabled: !_aplicarTasaDelPrestamo,
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 25.0),
    //                   child: MyCheckBox(title: "Aplicar tasa del prestamo", value: _aplicarTasaDelPrestamo, onChanged: _aplicarTasaDelPrestamoChanged,),
    //                 ),
    //                 MyTextFormField(
    //                   // labelText: "Cliente",
    //                   title: "Dias de gracia",
    //                   controller: _txtDiasGracia,
    //                   hint: "Dias de gracia",
    //                 ),
    //               ],
    //             ),
                
              
    //         ],),
    //       ),
        
    //     );
    //   }
    // );
                          
  }

  _garanteScreen(){
    return  Padding(
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
    );
                          
  }
  
  _gastoScreen(){
    return  StreamBuilder<List<Tipo>>(
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
    );
  }

  _garantiaScreen(){
    return StreamBuilder<List<Tipo>>(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: FlatButton(child: Text("Agregar garantia a este prestamo", style: TextStyle(letterSpacing: 0.3, color: Utils.fromHex("#2579e8"), fontWeight: FontWeight.w600, fontFamily: "Roboto" )), onPressed: (){_showModalGarantia();}),
                    ),
                    // myButton(function: (){}, text: "Agregar garantia", color: Colors.green)
                ],
                ),
                StreamBuilder<List<Garantia>>(
                  stream: _streamControllerGarantia.stream,
                  builder: (context, snapshot){
                    // if(snapshot.hasData == false)
                    //   return Center(child: CircularProgressIndicator(),);

                    return _buildDataTable(snapshot.data);
                  },
                )
              
            ],),
          ),
        );
      }
    );
                          
  }

  _desembolsoScreen(){
    return  StreamBuilder<List<Tipo>>(
      stream: _streamControllerTipo.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData == false)
          return CircularProgressIndicator();

        return Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 20.0),
          child: DraggableScrollbar(
            controller: _scrollControllerDesembolso,
            // alwaysVisibleScrollThumb: true,
            // heightScrollThumb: 2,
            heightScrollThumb: 80.0,
            // backgroundColor: Utils.colorPrimaryBlue,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: 
                Wrap(
                  children: [
                      // MySubtitle(title: "Garante"),
                      // MyDropdownButton(onChanged: null, elements: ["Jean"], title: "Culo",)
                      MySubtitle(title: "Origen empresa", fontSize: 15, padding: EdgeInsets.only(bottom: 15.0, top: 8)),
                      MyDropdownButton(
                        xlarge: 4,
                          title: "Tipo desembolso",
                          elements: listaTipo.where((element) => element.renglon == "desembolso").toList().map<String>((e) => e.descripcion).toList(),
                          onChanged: (listaTipo.where((element) => element.renglon == "desembolso").toList().length == 0) ? null : (data){
                            setState(() => _tipoDesembolso = listaTipo.firstWhere((element) => element.descripcion == data && element.renglon == "desembolso"));
                          },
                        ),
                      MyDropdownButton(
                        enabled: _tipoDesembolso.descripcion == "Cheque" || _tipoDesembolso.descripcion == "Transferencia",
                        xlarge: 4,
                          title: "Banco",
                          elements: (listaBanco.length > 0) ? listaBanco.map<String>((e) => e.descripcion).toList() : ["No hay bancos"],
                          onChanged: (listaBanco.length == 0) ? null : _cbxBancoOnChanged,
                        ),
                      StreamBuilder<List<Cuenta>>(
                        stream: _streamControllerCuenta.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData)
                            return MyDropdownButton(
                              enabled: _tipoDesembolso.descripcion == "Cheque" || _tipoDesembolso.descripcion == "Transferencia",
                              xlarge: 4,
                                title: "Cuenta de banco",
                                elements: (snapshot.data.length > 0) ? snapshot.data.map<String>((e) => e.descripcion).toList() : ["No hay cuentas"],
                                onChanged: (snapshot.data.length == 0) ? null : _cbxCuentaOnChanged,
                              );

                            return MyDropdownButton(
                              enabled: _tipoDesembolso.descripcion == "Cheque",
                              xlarge: 4,
                                title: "Cuenta de banco",
                                elements: ["No hay cuentas"],
                                onChanged: (data){},
                              );
                        }
                      ),
                      MyTextFormField(
                        // labelText: "Cliente",
                        title: "Numero de cheque",
                        controller: _txtNumeroCheque,
                        xlarge: 4,
                      ),
                      MySubtitle(title: "Cuenta destino cliente", fontSize: 15, padding: EdgeInsets.only(top: 15, bottom: 12),),
                      MyDropdownButton(
                        enabled: _tipoDesembolso.descripcion == "Cheque" || _tipoDesembolso.descripcion == "Transferencia",
                        xlarge: 2,
                          title: "Banco destino",
                          elements: (listaBanco.length > 0) ? listaBanco.map<String>((e) => e.descripcion).toList() : ["No hay bancos"],
                          onChanged: (listaBanco.length == 0) ? null : _cbxBancoDestinoOnChanged,
                        ),
                      MyTextFormField(
                        // labelText: "Cliente",
                        title: "Cuenta destino",
                        controller: _txtCuentaDestino,
                        xlarge: 2,
                      ),
                     
                      
                      
                  ],
                )
              
            ,),
          ),
        );
      }
    );
  }

  // _addToListMenu(){
  //  setState((){
  //     listaTab.add("Nuevo");
  //   _tabController = TabController(length: listaTab.length, vsync: this);
  //  });
  // }

  _updateTab(ConfiguracionPrestamo configuracionPrestamo){
    if(configuracionPrestamo.garantia == false)
      listaTab.removeWhere((element) => element == "Garantia");
    if(configuracionPrestamo.gasto == false)
      listaTab.removeWhere((element) => element == "Gasto");
    if(configuracionPrestamo.desembolso == false)
      listaTab.removeWhere((element) => element == "Desembolso");

      setState(() => _tabController = TabController(length: listaTab.length, vsync: this));
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      prestamos: true,
      body: [
        MyHeader(title: "Prestamo", subtitle: "Agregue todos los prestamos con sus respectivas garantias, garantes y cobradores.", function: _create, actionFuncion: "en proceso...",),
         
        Expanded(
          child: StreamBuilder(
            stream: _streamControllerTipo.stream,
            builder: (context, snapshot){
              if(snapshot.hasData)
                return _screen();
              else 
                return Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Theme(
                      data: Theme.of(context).copyWith(accentColor: Utils.colorPrimaryBlue),
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                );
            }
          ),
        )
      ] 
    );
  }
}