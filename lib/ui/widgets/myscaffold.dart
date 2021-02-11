import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/myappbar.dart';
import 'package:prestamo/ui/widgets/mynestedscrollbar.dart';
import 'package:prestamo/ui/widgets/mywebdrawer.dart';

myScaffold({@required BuildContext context, key, @required bool cargando, Widget myNestedScrollBar, List<Widget> body, sliverBody, bool clientes = false, bool rutas = false, bool gastos = false, bool cajas = false, bool bancos = false, bool prestamos = false, bool configuracionPrestamo = false, bool configuracionEmpresa = false, bool cuentas = false, bool roles = false, bool sucursales = false, bool usuarios = false, bool resizeToAvoidBottomInset = true, bool isSliverAppBar = false}){
  Widget widget = SizedBox();
  // if(myNestedScrollBar != null)
  //   widget = myNestedScrollBar;
    // MyNestedScrollBar(
    //     headerSliverBuilder: [SliverToBoxAdapter(child: Container(width: 200, height: 200, color: Colors.blue),)],
    //     body: Container(child: Text("Holaaa"), color: Colors.red),
    //   );

    if(myNestedScrollBar != null)
      widget = myNestedScrollBar;
    else if(body != null || sliverBody != null)
      widget = Row(
        children: [
        MyWebDrawer(clientes: clientes, cajas: cajas, rutas: rutas, gastos: gastos, bancos: bancos, prestamos: prestamos, configuracionPrestamo: configuracionPrestamo, configuracionEmpresa: configuracionEmpresa, cuentas: cuentas, roles: roles, sucursales: sucursales, usuarios: usuarios,),
        Visibility(visible: !Utils.isSmallOrMedium(MediaQuery.of(context).size.width), child: SizedBox(width: 50)), 
        Expanded(
          child:
          (sliverBody != null)
          ?
          sliverBody
          :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body,
          ),
        )
      ]);
    

    print("MyScaffold widget: ${myNestedScrollBar == null}");

  return Scaffold(
    resizeToAvoidBottomInset: false,
    key: key,
      backgroundColor: Colors.white,
      // drawer: Drawer( child: ListView(children: [
      //   ListTile(
      //     leading: Icon(Icons.home),
      //     title: Text("Inicio"),
      //   )
      // ],),),
      appBar: (isSliverAppBar == true && (ScreenSize.isMedium(MediaQuery.of(context).size.width) || ScreenSize.isSmall(MediaQuery.of(context).size.width))) ? null : myAppBar(context: context, cargando: cargando),
      body: (myNestedScrollBar != null) ? myNestedScrollBar : widget
      // body: MyNestedScrollBar(
      //   headerSliverBuilder: [SliverToBoxAdapter(child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.blue),), SliverToBoxAdapter(child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.red),)],
      //   body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.yellow),
      // )
  );
  
}