import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/prestamo.dart';
import 'package:prestamo/core/services/loanservice.dart';
import 'package:prestamo/ui/widgets/draggablescrollbar.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mydescription.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/mynestedscrollbar.dart';
import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytable.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ShowPrestamo extends StatefulWidget {
  final Prestamo prestamo;
  ShowPrestamo({Key key, this.prestamo}) : super(key: key);
  @override
  _ShowPrestamoState createState() => _ShowPrestamoState();
}

class _ShowPrestamoState extends State<ShowPrestamo> with TickerProviderStateMixin {
  AppDatabase db;
  ScrollController _scrollController;
  TabController _tabController;
  StreamController<Prestamo> _streamController;
  Prestamo _prestamo;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    _streamController = BehaviorSubject();
    super.initState();
  }

  _init() async {
    var prestamo = await LoanService.show(context: context, prestamo: widget.prestamo, db: db);
    if(prestamo["prestamo"] != null){
      _prestamo = Prestamo.fromMap(prestamo["prestamo"]);
      // print("_init Prestamo: ${json.decode(prestamo["prestamo"]["amortizaciones"])}");
      print("_init Prestamo: ${_prestamo.toJson()}");
      _streamController.add(_prestamo);
    }
  }

  _pagar(){
    // showDialog(
    //   context: context,
    //   builder: (context){
    //     return MyAlertDialog(
    //       title: "Cobrar", 
    //       description: "Realiza cobros, descuenta interes al cliente, asigna o quita mora, agrega comentario y mucho mas.",
    //       content: Wrap(
    //         children: [
    //           MyTextFormField(
    //             controller: _txtMonto,
    //             hint: "Monto recibito",
    //           ),
    //         ],
    //       ), 
    //       okFunction: null
    //     );
    //   }
    // );
  }

  _editar(){

  }

  _contrato(){

  }

  _exportar(){

  }

  _customerScreen(AsyncSnapshot<Prestamo> snapshot){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: 
      // ListTile(
      //   leading: Utils.getCustomerPhoto(widget.prestamo.cliente.nombreFoto, size: 120),
      //   title: Text("${snapshot.data.cliente.nombres} ${snapshot.data.cliente.apellidos}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, letterSpacing: 0.2, fontFamily: "GoogleSans"),),
      //   subtitle: Text("031-0563805-4"),
      // )
      Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Utils.getCustomerPhoto(widget.prestamo.cliente.nombreFoto, size: 80),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${snapshot.data.cliente.nombres} ${snapshot.data.cliente.apellidos}", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, fontFamily: "GoogleSans"),),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Wrap(children: [
                MyDescripcon(title: "${snapshot.data.cliente.documento.descripcion}", fontSize: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                ),
                MyDescripcon(title: "${snapshot.data.cliente.contacto.celular}", fontSize: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),),
                ),
                MyDescripcon(title: "${snapshot.data.cliente.contacto.correo}", fontSize: 15,),

              ],),
            )
          ],
        )
      ],),
    );
                      
  }

  _loanDetailsScreen(AsyncSnapshot<Prestamo> snapshot){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 23.0),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: MySubtitle(title: "Prestamo", fontSize: 18,),
        ),
        Wrap(
          children: [
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Pagado", fontSize: 15,),
                  Text("${Utils.toCurrency(0)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Proximo pago", fontSize: 15,),
                  Text("0000-00-00", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Balance pendiente", fontSize: 15,),
                  Text("${Utils.toCurrency(snapshot.data.monto)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Cuotas", fontSize: 15,),
                  Text("0/${snapshot.data.numeroCuotas}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Prestado", fontSize: 15,),
                  Text("${Utils.toCurrency(snapshot.data.monto)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Interes", fontSize: 15,),
                  Text("${snapshot.data.porcentajeInteres}%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Mora", fontSize: 15,),
                  Text("${snapshot.data.porcentajeMora}%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),

            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Plazo", fontSize: 15,),
                  Text("Mensual", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),
            MyResizedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDescripcon(title: "Amortizacion", fontSize: 15,),
                  Text("Insoluto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),),
                  // MyDescripcon(title: "0/3", fontSize: 15,),
                ],
              ),
            ),
          ],
        )
      ]
    );
                    
  }

  _screen(){
    return StreamBuilder<Prestamo>(
            stream: _streamController.stream,
            builder: (context, snapshot){
              if(snapshot.hasData)
              // return MyNestedScrollBar(
              //   // controller: _scrollController,
              //   headerSliverBuilder:
              //       [
              //     SliverToBoxAdapter(
              //         child: Column(
              //           children: [
              //             _customerScreen(snapshot),
              //             _loanDetailsScreen(snapshot),
              //             MySubtitle(title: "Detalles", fontSize: 18,),
              //           ],
              //         )
              //     ),
              //     SliverToBoxAdapter(
              //       child: TabBar(
              //           controller: _tabController,
              //           isScrollable: true,
              //           labelStyle: TextStyle(color: Utils.colorPrimaryBlue, fontWeight: FontWeight.w700),
              //           unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              //           labelColor: Colors.black,
              //           // indicatorWeight: 4.0,
              //           indicator: CircleTabIndicator(color: Utils.colorPrimaryBlue, radius: 5),
              //           tabs: [
              //             Tab(
              //               child: Text("Amortizacion"),
              //             ),
              //             Tab(
              //               child: Text("Pagos"),
              //             ),
                         
              //           ],
              //         ),
              //     ),
              //   ], 
              //   body: TabBarView(
              //           controller: _tabController,
              //             children: [
              //               // Center(child: Text("En progreso..."),),
              //               MyTable(
              //                 columns: ["#", "Fecha", "Capital", "Interes", "Cuota"], 
              //                 rows: snapshot.data.amortizaciones.asMap().map((index, value) => MapEntry(index, [null, "${index + 1}", "${value.fecha.toString()}", "${Utils.toCurrency(value.capital)}", "${Utils.toCurrency(value.interes)}", "${Utils.toCurrency(value.cuota)}"])).values.toList()
              //               ),
              //               Center(child: Text("En progreso..."),),
              //             ]
              //           ),
              // );
              return MyNestedScrollBar(
                headerSliverBuilder: [
                  SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _customerScreen(snapshot),
                          _loanDetailsScreen(snapshot),
                          MySubtitle(title: "Detalles", fontSize: 18,),
                        ],
                      )
                  ),
                  SliverToBoxAdapter(
                    child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelStyle: TextStyle(color: Utils.colorPrimaryBlue, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        labelColor: Colors.black,
                        // indicatorWeight: 4.0,
                        indicator: CircleTabIndicator(color: Utils.colorPrimaryBlue, radius: 5),
                        tabs: [
                          Tab(
                            child: Text("Amortizacion"),
                          ),
                          Tab(
                            child: Text("Pagos"),
                          ),
                         
                        ],
                      ),
                  ),
                ], 
                body: TabBarView(
                        controller: _tabController,
                        children: [
                            // Center(child: Text("En progreso..."),),
                            ListView(
                            // scrollDirection: Axis.horizontal,
                              children: [
                                DataTable(
                                  columns: [ DataColumn(label: Text("Fecha")), DataColumn(label: Text("Capital")), DataColumn(label: Text("Interes")), DataColumn(label: Text("Cuota"))], 
                                  rows: snapshot.data.amortizaciones.map<DataRow>((value) => DataRow(cells: [ DataCell(Text("${value.fecha.toString()}")), DataCell(Text("${Utils.toCurrency(value.capital)}")), DataCell(Text("${Utils.toCurrency(value.interes)}")), DataCell(Text("${Utils.toCurrency(value.cuota)}"))])).toList()
                                ),
                              ],
                            ),
                            // MyTable(
                            //   columns: ["#", "Fecha", "Capital", "Interes", "Cuota"], 
                            //   rows: snapshot.data.amortizaciones.asMap().map((index, value) => MapEntry(index, [null, "${index + 1}", "${value.fecha.toString()}", "${Utils.toCurrency(value.capital)}", "${Utils.toCurrency(value.interes)}", "${Utils.toCurrency(value.cuota)}"])).values.toList()
                            // ),
                            Center(child: Text("En progreso..."),),
                          ]
                        ),
              );
                // return Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     _customerScreen(snapshot),
                //     _loanDetailsScreen(snapshot),
                //     MySubtitle(title: "Detalles", fontSize: 18,),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 15.0),
                //       child: TabBar(
                //         controller: _tabController,
                //         isScrollable: true,
                //         labelStyle: TextStyle(color: Utils.colorPrimaryBlue, fontWeight: FontWeight.w700),
                //         unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                //         labelColor: Colors.black,
                //         // indicatorWeight: 4.0,
                //         indicator: CircleTabIndicator(color: Utils.colorPrimaryBlue, radius: 5),
                //         tabs: [
                //           Tab(
                //             child: Text("Amortizacion"),
                //           ),
                //           Tab(
                //             child: Text("Pagos"),
                //           ),
                         
                //         ],
                //       ),
                //     ),
                    // Expanded(
                    //   child: TabBarView(
                    //     controller: _tabController,
                    //       children: [
                    //         // Center(child: Text("En progreso..."),),
                    //         MyTable(
                    //           columns: ["#", "Fecha", "Capital", "Interes", "Cuota"], 
                    //           rows: snapshot.data.amortizaciones.asMap().map((index, value) => MapEntry(index, [null, "${index + 1}", "${value.fecha.toString()}", "${Utils.toCurrency(value.capital)}", "${Utils.toCurrency(value.interes)}", "${Utils.toCurrency(value.cuota)}"])).values.toList()
                    //         ),
                    //         Center(child: Text("En progreso..."),),
                    //       ]
                    //     ),
                    // )
                    
                //   ],
                // );

                return Center(child: CircularProgressIndicator(),);
            }
          );
        
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    db = Provider.of<AppDatabase>(context);
    _init();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return myScaffold(
      cargando: false,
      context: context,
      prestamos: true,
      // myNestedScrollBar: 
    //  MyNestedScrollBar(
    //     headerSliverBuilder: [SliverToBoxAdapter(child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.blue),), SliverToBoxAdapter(child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.red),)],
    //     body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.yellow),
    //   ),
      
      // MyNestedScrollBar(
      //   headerSliverBuilder: [SliverToBoxAdapter(child: Container(width: 200, height: 200, color: Colors.blue),)],
      //   body: Container(child: Text("Holaaa"), color: Colors.red),
      // )
      // MyNestedScrollBar(
      //   headerSliverBuilder: [
      //     SliverToBoxAdapter(
      //       child: MyHeader(
      //         title: "Detalle", 
      //         customFunction: Padding(
      //           padding: const EdgeInsets.only(right: 15.0),
      //           child: Row(children: [
      //             FlatButton(onPressed: _exportar, child: Text("Exportar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
      //             FlatButton(onPressed: _contrato, child: Text("Contrato", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
      //             FlatButton(onPressed: _editar, child: Text("Editar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
      //             myButton(function: _pagar, text: "Pagar"),
                  
      //           ],),
      //         ),
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: _screen()
      //     )
      //   ],
      //   body: 
      //   // Container(child: Text("hola"),)
      //   StreamBuilder<Prestamo>(
      //     stream: _streamController.stream,
      //     builder: (context, snapshot) {
      //       if(snapshot.hasData)
      //       return TabBarView(
      //         controller: _tabController,
      //           children: [
      //             // Center(child: Text("En progreso..."),),
      //       //  Container(height: MediaQuery.of(context).size.height, width:  MediaQuery.of(context).size.width, color: Colors.green),
      //             ListView(
      //               // scrollDirection: Axis.horizontal,
      //               children: [
      //                   DataTable(
      //                     columns: [ DataColumn(label: Text("Fecha")), DataColumn(label: Text("Capital")), DataColumn(label: Text("Interes")), DataColumn(label: Text("Cuota"))], 
      //                     rows: snapshot.data.amortizaciones.map<DataRow>((value) => DataRow(cells: [ DataCell(Text("${value.fecha.toString()}")), DataCell(Text("${Utils.toCurrency(value.capital)}")), DataCell(Text("${Utils.toCurrency(value.interes)}")), DataCell(Text("${Utils.toCurrency(value.cuota)}"))])).toList()
      //                   ),
      //                     Text("Que bendito culo")
      //                 ],
      //               ),
                  
      //             // MyTable(
      //             //   columns: ["#", "Fecha", "Capital", "Interes", "Cuota"], 
      //             //   rows: snapshot.data.amortizaciones.asMap().map((index, value) => MapEntry(index, [null, "${index + 1}", "${value.fecha.toString()}", "${Utils.toCurrency(value.capital)}", "${Utils.toCurrency(value.interes)}", "${Utils.toCurrency(value.cuota)}"])).values.toList()
      //             // ),
      //             Center(child: Text("En progreso..."),),
      //           ]
      //         );
      //       return Container(height: MediaQuery.of(context).size.height, width:  MediaQuery.of(context).size.width, color: Colors.green); 

      //       return Container(height: MediaQuery.of(context).size.height, child: Center(child: CircularProgressIndicator()));
      //     }
      //   ),
      //         ),
        
        // body:[ Container(child: Text("Errr culo"),)]
      // );
      body: [
        MyHeader(
          title: "Detalle", 
          customFunction: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(children: [
              FlatButton(onPressed: _exportar, child: Text("Exportar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              FlatButton(onPressed: _contrato, child: Text("Contrato", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              FlatButton(onPressed: _editar, child: Text("Editar", style: TextStyle(fontFamily: "GoogleSans", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(.7)),)),
              myButton(function: _pagar, text: "Pagar")
            ],),
          ),
        ),
        Expanded(
          child:  _screen()
            
        )
      ]
    );
  }
}