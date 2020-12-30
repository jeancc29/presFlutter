import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/prestamo.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/services/loanservice.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myiconbutton.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mytable.dart';
import 'package:rxdart/rxdart.dart';

class PrestamosScreen extends StatefulWidget {
  @override
  _PrestamosScreenState createState() => _PrestamosScreenState();
}

class _PrestamosScreenState extends State<PrestamosScreen> {
  StreamController<List<Prestamo>> _streamController;
  var _txtSearchController = TextEditingController();
  bool _cargando = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Prestamo> listaPrestamo = List();
  List<Tipo> listaTipo = List();
  List<Tipo> listaPlazo = List();

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  _init() async {
    var parsed = await LoanService.index(context: context);
    print("_init ${parsed["prestamos"]}");
    //  parsed["prestamos"].forEach((e){
    //   Prestamo.fromMap(e);
    //   // print("tipoAmortizacion is type: ${e["caja"]["descripcion"]}");
    // }).toList();
    listaPrestamo = parsed["prestamos"].map<Prestamo>((e) => Prestamo.fromMap(e)).toList();
    listaTipo = parsed["tipos"].map<Tipo>((e) => Tipo.fromMap(e)).toList();
    listaPlazo = listaTipo.where((element) => element.renglon == "plazo").toList();
    listaPrestamo.forEach((element) {print("prestamo cliente: ${element.tipoAmortizacion.descripcion}");});
    _streamController.add(listaPrestamo);
  }

  _agregar() async {
    dynamic data = await Navigator.pushNamed(context, "/addPrestamo");
    if(data == null)
      return;

    if(!(data is Prestamo))
      return;

    int idx = listaPrestamo.indexWhere((element) => element.id == data.id);
    if(idx == -1){
      listaPrestamo.add(data);
      _streamController.add(listaPrestamo);
    }
    else{
      listaPrestamo[idx] = data;
      _streamController.add(listaPrestamo);
    }
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

  _search(String data){
    if(data.isEmpty)
      _streamController.add(listaPrestamo);
    else{
      _streamController.add(listaPrestamo.where((element) => (element.cliente.nombres.toLowerCase().indexOf(data) != -1 || element.cliente.apellidos.toLowerCase().indexOf(data) != -1) || element.codigo.toLowerCase().indexOf(data) != -1).toList());
    }
  }

  _onFechaInicialChanged(DateTime fecha){

  }

  _onFechaFinalChanged(DateTime fecha){

  }

  _onFechaProximoPagoChanged(DateTime fecha){

  }

  _filter(){

  }

  _showDialogFiltrar(){
    showDialog(
      context: context,
      builder: (context){
        return MyAlertDialog(
          title: "Filtrar prestamos", 
          description: "Filtra entre fechas, fecha proximo pago, prestamos al dia, mora y mucho mas...",
          content: Wrap(
            children: [
              MyDatePicker(initialHint: "Todas las fechas", medium: 2, title: "Fecha inicial", initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaInicialChanged),
              MyDatePicker(initialHint: "Todas las fechas", medium: 2, title: "Fecha final", initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaFinalChanged, ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: MyDatePicker(initialHint: "Todas las fechas", title: "Fecha proximo pago", initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaProximoPagoChanged, ),
              ),
              MyDropdownButton(
                title: "Estado",
                elements: ["Todos", "Al dia", "Pendiente", "Cuota Vencida", "Mora", "Cancelado"],
                onChanged: (data){},
              ),
              MyDropdownButton(
                title: "Plazo",
                elements: listaPlazo.map<String>((e) => e.descripcion).toList(),
                onChanged: (data){},
              )
            ],
          ), 
          okFunction: null
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      key: _scaffoldKey,
      context: context,
      cargando: _cargando,
      prestamos: true,
      body: [
        MyHeader(title: "Prestamos", subtitle: "Vea todos sus prestamos y filtrelos por fecha, estado, nombre y cedula del cliente.", function: _agregar, actionFuncion: "Agregar",),
        Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Wrap(
             children: [
                MyDatePicker(initialHint: "Todas las fechas", title: "Fecha inicial", isDropdown: true, initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaInicialChanged),
                MyDatePicker(initialHint: "Todas las fechas", title: "Fecha final", isDropdown: true, initialEntryMode: DatePickerEntryMode.calendar, onDateTimeChanged: _onFechaFinalChanged, ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: FlatButton(onPressed: (){}, child: Text("Buscar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)))),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 33.0),
                //   child: myIconButton(function: _filter, icon: Icons.search, color: Colors.green),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: FlatButton(onPressed: _showDialogFiltrar, child: Text("Mas filtros...", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.5)))),
                ),
                
             ],
           ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 18.0),
                child: MySearchField(controller: _txtSearchController, onChanged: _search, hint: "Buscar por cliente o codigo prestamo...", xlarge: 3.0,),
              ))
          ],
        ),
        StreamBuilder<List<Prestamo>>(
          stream: _streamController.stream,
          builder: (context, snapshot){
            if(snapshot.hasData)
            return MyTable(
              columns: ["Estado", "Cliente", "Monto prestado", "Monto Cuota", "Balance pendiente", "Capital pendiente", "Proximo pago", "# Cuota", "Amortizacion", "Pagado", "Codigo", "Caja"], 
              rows: snapshot.data.map((e) => ["Al dia", Row(children: [_getCustomerPhoto(e.cliente.nombreFoto), Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text("${e.cliente.nombres} ${e.cliente.apellidos}"),
              )]), "${e.monto}", "${e.cuota}", "${e.balancePendiente}", "${e.capitalPendiente}", "${e.fechaProximoPago}", "${e.numeroCuotas}", "${e.tipoAmortizacion.descripcion}", "${e.montoPagado}", "${e.codigo}", "${e.caja.descripcion}"]).toList()
            );
            return MyTable(
              columns: ["Estado", "Cliente", "Monto prestado", "Monto Cuota", "Balance pendiente", "Capital pendiente", "Proximo pago", "# Cuota", "Amortizacion", "Pagado", "Codigo", "Caja"], 
              rows: []
            );
          }
        ),
        
      ]
    );
  }
}