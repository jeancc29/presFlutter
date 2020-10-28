import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/myappbar.dart';
import 'package:prestamo/ui/widgets/mywebdrawer.dart';

myScaffold({@required BuildContext context, bool cargando, List<Widget> body, bool clientes = false, bool rutas = false, bool gastos = false, bool cajas = false, bool bancos = false, bool prestamos = false}){
  return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer( child: ListView(children: [
      //   ListTile(
      //     leading: Icon(Icons.home),
      //     title: Text("Inicio"),
      //   )
      // ],),),
      appBar: myAppBar(context: context, cargando: cargando),
      body: Row(children: [
        MyWebDrawer(clientes: clientes, cajas: cajas, rutas: rutas, gastos: gastos, bancos: bancos, prestamos: prestamos,),
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