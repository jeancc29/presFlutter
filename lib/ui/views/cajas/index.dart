import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/myheader.dart';
import 'package:prestamo/ui/widgets/myscaffold.dart';

class CajasScreen extends StatefulWidget {
  @override
  _CajasScreenState createState() => _CajasScreenState();
}

class _CajasScreenState extends State<CajasScreen> {
  bool _cargando = false;
  _goToAddCaja() async {
    var data = await Navigator.pushNamed(context, "/AddCaja", arguments: null);
  }
  @override
  Widget build(BuildContext context) {
    return myScaffold(
      context: context,
      cargando: _cargando,
      body: [
        MyHeader(title: "Cajas", function: _goToAddCaja, actionFuncion: "Agregar",),
        Expanded(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     padding: EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey.shade300,  width: 0.9),
              //       borderRadius: BorderRadius.circular(5)
              //     ),
              //     child: Row(children: [
              //       Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text("Caja1", style: TextStyle(fontSize: 20),)
              //             ],
              //           ),
              //         ],
              //       )
              //     ],),
              //   ),
              // ),
              SizedBox(height: 20,),
              // Text("Diseno 1", style: TextStyle(fontSize: 20),),
              SizedBox(height: 2,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300,  width: 0.9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                        // selected: true,
                        title: Text("Caja 1"),
                        subtitle: Text("\$RD 2,000.00"),
                        trailing: Icon(Icons.more_horiz, size: 30,),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300,  width: 0.9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                        title: Text("Caja 1"),
                        subtitle: Text("\$RD 2,000.00"),
                        trailing: Icon(Icons.more_horiz, size: 30,),
                      ),
                ),
              ),
              // SizedBox(height: 20,),
              // Text("Diseno 2", style: TextStyle(fontSize: 20),),
              // SizedBox(height: 2,),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //     child: ListTile(
              //       title: Text("Caja 1"),
              //       subtitle: Text("\$RD 2,000.00"),
              //       trailing: Icon(Icons.more_horiz, color: Utils.colorPrimaryBlue, size: 30,),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //     child: ListTile(
              //       title: Text("Caja 1"),
              //       subtitle: Text("\$RD 2,000.00"),
              //       trailing: Icon(Icons.more_horiz, color: Utils.colorPrimaryBlue, size: 30,),
              //     ),
              //   ),
              // ),
             
            ],
          ),
        )
      ]
    );
  }
}