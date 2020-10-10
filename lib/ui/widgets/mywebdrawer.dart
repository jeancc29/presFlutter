import 'dart:html';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/services/boxservice.dart';
import 'package:prestamo/ui/views/cajas/abrir.dart';
import 'package:prestamo/ui/views/clientes/index.dart';
import 'package:prestamo/ui/widgets/myexpansiontile.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';

class MyWebDrawer extends StatefulWidget {
  final bool inicio;
  final bool clientes;
  final bool rutas;
  final bool gastos;
  final bool cajas;
  final bool bancos;
  final bool clientesBack;
  MyWebDrawer({Key key, this.inicio = false, this.clientes = false, this.rutas = false, this.gastos = false, this.cajas = false, this.bancos = false, this.clientesBack = false}) : super(key: key);
  @override
  _MyWebDrawerState createState() => _MyWebDrawerState();
}

class _MyWebDrawerState extends State<MyWebDrawer> {
  bool _cargandoAbrirCaja = false;
  _gotTo(String route){
    Navigator.pushNamed(context, route);
  }

  _abrirCaja() async {
    try {
      setState(() => _cargandoAbrirCaja = true);
      var parsed = await BoxService.index(context: context);
      setState(() => _cargandoAbrirCaja = false);
      List<Caja> lista = parsed["cajas"].map<Caja>((value) => Caja.fromMap(value)).toList();
      if(lista.length > 0)
        abrirCaja(context: context, cajas: lista);
      else
        Utils.showAlertDialog(context: context, content: "No hay cajas registradas", title: "No hay cajas");
    } catch (e) {
      print("Errorrrr myWebDrawer _abrirCaja");
      setState(() => _cargandoAbrirCaja = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
          visible: MediaQuery.of(context).size.width > ScreenSize.md,
          child: Container(
            // color: Colors.red,
            width: 260,
            height: MediaQuery.of(context).size.height,
            child: ListView(children: [
              SizedBox(height: 5,),
              Visibility(
                visible: ModalRoute.of(context)?.canPop == true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                                    Navigator.pop(context);

                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [
                        Icon(Icons.arrow_back, size: 18,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Atras", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade800),),
                        )
                      ],),
                    ),
                  ),
                ),
              ),
              MyListTile(title: "Inicio", icon: Icons.apps, selected: widget.inicio, ),
              MyListTile(title: "Clientes", icon: Icons.people, selected: widget.clientes, onTap: (){_gotTo("/clientes");},),
              MyListTile(title: "Rutas", icon: Icons.location_on, selected: widget.rutas, onTap: (){_gotTo("/rutas");},),
              MyListTile(title: "Gastos", icon: Icons.money_off, selected: widget.gastos, onTap: (){_gotTo("/gastos");},),
              // MyListTile(title: "Usuarios y permisos", icon: Icons.recent_actors),
              // MyListTile(title: "Cajas", icon: Icons.attach_money, selected: widget.cajas, onTap: (){_gotTo("/cajas");}),
              MyExpansionTile(
                title: "Cajas", 
                icon: Icons.attach_money, 
                initialExpanded: widget.cajas,
                listaMylisttile: [
                  MyListTile(title: "Editar", icon: null, onTap: (){_gotTo("/cajas");}, selected: widget.cajas,), 
                  MyListTile(title: "Aperturar caja", icon: null, onTap: _abrirCaja, cargando: _cargandoAbrirCaja,),
                  MyListTile(title: "Cierres", icon: null,), 
                ]
              ),
              MyExpansionTile(
                title: "General", 
                icon: Icons.attach_money, 
                initialExpanded: widget.bancos,
                listaMylisttile: [
                  MyListTile(title: "Bancos", icon: null, onTap: (){_gotTo("/bancos");}, selected: widget.bancos,), 
                ]
              ),
              MyListTile(title: "Pagos", icon: Icons.payment, selected: false,),

            ],),
          ),
        );
  }
}