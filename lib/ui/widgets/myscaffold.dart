import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/myappbar.dart';
import 'package:prestamo/ui/widgets/mywebdrawer.dart';

myScaffold({@required BuildContext context, key, @required bool cargando, List<Widget> body, bool clientes = false, bool rutas = false, bool gastos = false, bool cajas = false, bool bancos = false, bool prestamos = false, bool configuracionPrestamo = false, bool cuentas = false}){
  return Scaffold(
    key: key,
      backgroundColor: Colors.white,
      // drawer: Drawer( child: ListView(children: [
      //   ListTile(
      //     leading: Icon(Icons.home),
      //     title: Text("Inicio"),
      //   )
      // ],),),
      appBar: myAppBar(context: context, cargando: cargando),
      body: Row(children: [
        MyWebDrawer(clientes: clientes, cajas: cajas, rutas: rutas, gastos: gastos, bancos: bancos, prestamos: prestamos, configuracionPrestamo: configuracionPrestamo, cuentas: cuentas),
        SizedBox(width: 40), 
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body,
          ),
        )
      ])
  );
  
}