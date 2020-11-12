import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/configuracionprestamo.dart';
import 'package:prestamo/core/services/loansettingservice.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:rxdart/rxdart.dart';

class ConfiguracionPrestamoScreen extends StatefulWidget {
  @override
  _ConfiguracionPrestamoScreenState createState() => _ConfiguracionPrestamoScreenState();
}

class _ConfiguracionPrestamoScreenState extends State<ConfiguracionPrestamoScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamController<ConfiguracionPrestamo> _streamController;
  bool _cargando = false;
  bool _garantia = false;
  bool _gasto = false;
  bool _desembolso = false;
  ConfiguracionPrestamo configuracionPrestamo = ConfiguracionPrestamo();
  
  _init() async {
    try {
      // setState(() => _cargando = true);
      var parsed = await LoansettingService.index(context: context, );
      configuracionPrestamo = ConfiguracionPrestamo.fromMap(parsed["configuracionPrestamo"]);
      print("ConfiguracionPrestamoScreen _init parsed ${parsed}");
      print("ConfiguracionPrestamoScreen _init ${configuracionPrestamo.toJson()}");
      _garantia = configuracionPrestamo.garantia;
      _gasto = configuracionPrestamo.gasto;
      _desembolso = configuracionPrestamo.desembolso;
      _streamController.add(configuracionPrestamo);
      // setState(() => _cargando = false);
    } catch (e) {
      print("ConfiguracionPrestamoScreen _init error: ${e.toString()}");
      // setState(() => _cargando = false);
    }
  }
  _guardar() async {
    try {
      setState(() => _cargando = true);
      configuracionPrestamo.garantia = _garantia;
      configuracionPrestamo.gasto = _gasto;
      configuracionPrestamo.desembolso = _desembolso;
      configuracionPrestamo = await LoansettingService.store(context: context, configuracionPrestamo: configuracionPrestamo);
      setState(() => _cargando = false);
      Utils.showSnackBar(content: "Se ha guardado correctamente", scaffoldKey: _scaffoldKey);
    } catch (e) {
      print("ConfiguracionPrestamoScreen _init error: ${e.toString()}");
      setState(() => _cargando = false);
    }
  }

  _screen(){
    return MyResizedContainer(
            xlarge: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("Activar garantia"),
                    ),
                    Switch(
                      onChanged: (data){
                        setState(() => _garantia = data);
                      },
                      value: _garantia,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("Activar gasto"),
                    ),
                    Switch(
                      onChanged: (data){
                        setState(() => _gasto = data);
                      },
                      value: _gasto,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("Activar desembolso"),
                    ),
                    Switch(
                      onChanged: (data){
                        setState(() => _desembolso = data);
                      },
                      value: _desembolso,
                    )
                  ],
                )
              ],
            ),
          );
        
  }

  @override
  void initState() {
    // TODO: implement initState
    _streamController = BehaviorSubject();
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myScaffold(
      key: _scaffoldKey,
      context: context,
      cargando: _cargando,
      configuracionPrestamo: true,
      body: [
        MyHeader(title: "Configuracion de prestamos", subtitle: "Agregue las garantias y gastos para que sus prestamos sean mas formales", function: _guardar, actionFuncion: "Guardar",),
        SizedBox(height: 20,),
        MySubtitle(title: "Detalles",),
        Expanded(
          child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot){
              if(snapshot.hasData)
                return _screen();

              return Center(child: CircularProgressIndicator(),);
            },
          )
        ),
       
      ]
    );
  }
}