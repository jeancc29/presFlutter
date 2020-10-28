import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/mysearch.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';

class PrestamoAddScreen extends StatefulWidget {
  @override
  _PrestamoAddScreenState createState() => _PrestamoAddScreenState();
}

class _PrestamoAddScreenState extends State<PrestamoAddScreen> with TickerProviderStateMixin {
  var _tabController;
  ScrollController _scrollController;
  var _formKey = GlobalKey<FormState>();
  var _txtCliente = TextEditingController();
  var _focusNodeTxtCliente = FocusNode();
  var _txtMonto = TextEditingController();
  bool _cargando = false;
  _create(){

  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      prestamos: true,
      body: [
        MyHeader(title: "Todas las apps", subtitle: "Mira todas las apps y los juegos a los que tienes acceso en tu cuenta de desarrollador", function: _create, actionFuncion: "Agregar",),
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
                          
                          Padding(
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
                                  MySearchField(
                                    // labelText: "Cliente",
                                    controller: _txtCliente,
                                    focusNode: _focusNodeTxtCliente,
                                    hint: "Buscar prestamo",
                                  ),
                                  MyTextFormField(
                                    // labelText: "Cliente",
                                    controller: _txtMonto,
                                    hint: "Monto",
                                  )
                               
                              ],),
                            ),
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
                                controller: _scrollController,
                                children: [
                               
                               
                              ],),
                            ),
                          ),
                          
                        ],
                      ),
                ),
              ),
             
      ] 
    );
  }
}