import 'package:flutter/material.dart';
import 'package:prestamo/ui/widgets/myalertdialog.dart';
import 'package:prestamo/ui/widgets/myscrollbar.dart';
import 'package:prestamo/ui/widgets/mytable.dart';

class PruebaScroll extends StatefulWidget {
  @override
  _PruebaScrollState createState() => _PruebaScrollState();
}

class _PruebaScrollState extends State<PruebaScroll> {
  ScrollController _controller;
  double _offset = 0;
  List<dynamic> listaPersona = List.generate(20, (index) => {"nombre" : "Jean $index", "apellido" : "Contreras $index"});

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  _abrirDialog(){
    showDialog(
      context: context,
      builder: (context){
        return MyAlertDialog(title: "Prueba scroll", content: Wrap(children: [
          Container(
            height: 100,
            child: MyScrollbar(child: Row(
              children: [
                Expanded(child: MyTable(columns: ["Nombre", "Apellido"], rows: listaPersona.map((e) => [e["nombre"], e["apellido"]]).toList())),
              ],
            ))
          )
        ],), okFunction: (){});
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DataTable(
          columns: [],
          rows: [
            DataRow(cells: [DataCell(Text("Hola")), DataCell(Text("Hola 2"))])
          ],
        ),
      )
      // Column(
      //   children: [
      //     Container(
      //       width: 240,
      //       child: MyScrollbar(
      //         widget: Container(
      //           width: 235,
      //           child: ListView(
      //             children: [
      //               Container(
      //                 height: 500,
      //                 width: MediaQuery.of(context).size.width,
      //                 color: Colors.blue,
      //               ),
      //               Container(
      //                 height: 500,
      //                 width: MediaQuery.of(context).size.width,
      //                 color: Colors.red,
      //               ),
      //               Container(
      //                 height: 500,
      //                 width: MediaQuery.of(context).size.width,
      //                 color: Colors.yellow,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // )
      // Stack(
      //   children: [
      //     Container(
      //       child: SingleChildScrollView(
      //         controller: _controller,
      //         child: Column(
      //           children: [
      //             Container(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               color: Colors.black,
      //             ),
      //             Container(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               color: Colors.red,
      //             ),
      //             Container(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               color: Colors.green,
      //             ),
      //             Container(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               color: Colors.blue,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     //Scroll bar
      //     Container(
      //         alignment: Alignment.centerRight,
      //         height: MediaQuery.of(context).size.height,
      //         width: 20.0,
      //         margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 20.0),
      //         // decoration: BoxDecoration(color: Colors.black12),
      //         child: Container(
      //           alignment: Alignment.topCenter,
      //             child: GestureDetector(
      //                 child: Container(
      //                 height: 40.0,
      //                 width: 5.0,
      //                 margin:
      //                     EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
      //                 decoration: BoxDecoration(
      //                     color: Colors.grey,
      //                     borderRadius: BorderRadius.all(Radius.circular(3.0))),
      //               ),
      //                 onVerticalDragUpdate: (dragUpdate) {
      //                   _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);

      //                   setState(() {
      //                      if(dragUpdate.globalPosition.dy >= 0) {
      //                        _offset = dragUpdate.globalPosition.dy;
      //                      }
      //                     print("View offset ${_controller.offset} scroll-bar offset ${_offset}");
      //                   });
      //                 },
      //           ),
      //         )
      //     ),
      //   ],
      // ),

      // Container(
        // height: 200,
        // child: Column(
        //   children: [
        //     Expanded(
        //       child: MyScrollbar(
        //         widget: Column(children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height,
        //             color: Colors.blue,
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height / 2,
        //             color: Colors.red,
        //           ),
        //           // Container(
        //           //   width: MediaQuery.of(context).size.width,
        //           //   height: MediaQuery.of(context).size.height,
        //           //   color: Colors.black,
        //           // ),
        //         ],),
        //       )
        //     ),
        //   ],
        // ),
        // child: Stack(
        //   children: [
        //     Container(
        //       child: SingleChildScrollView(
        //         controller: _controller,
        //         child: Column(
        //           children: [
        //             Container(
        //               height: MediaQuery.of(context).size.height,
        //               width: MediaQuery.of(context).size.width,
        //               color: Colors.black,
        //             ),
        //             Container(
        //               height: MediaQuery.of(context).size.height,
        //               width: MediaQuery.of(context).size.width,
        //               color: Colors.red,
        //             ),
        //             Container(
        //               height: MediaQuery.of(context).size.height,
        //               width: MediaQuery.of(context).size.width,
        //               color: Colors.green,
        //             ),
        //             Container(
        //               height: 40,
        //               width: MediaQuery.of(context).size.width,
        //               color: Colors.black,
        //             )
        //             // Container(
        //             //   height: MediaQuery.of(context).size.height,
        //             //   width: MediaQuery.of(context).size.width,
        //             //   color: Colors.blue,
        //             // ),
        //             // Container(
        //             //   height: MediaQuery.of(context).size.height,
        //             //   width: MediaQuery.of(context).size.width,
        //             //   color: Colors.brown,
        //             // ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     //Scroll bar
        //     Container(
        //         alignment: Alignment.centerRight,
        //         // height: MediaQuery.of(context).size.height,
        //         height: 200,
        //         width: 20.0,
        //         margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 20.0),
        //         // decoration: BoxDecoration(color: Colors.black12),
        //         child: Container(
        //           alignment: Alignment.topCenter,
        //             child: GestureDetector(
        //                 child: Container(
        //                 height: 40.0,
        //                 width: 5.0,
        //                 margin:
        //                     EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
        //                 decoration: BoxDecoration(
        //                     color: Colors.grey,
        //                     borderRadius: BorderRadius.all(Radius.circular(3.0))),
        //               ),
        //                 onVerticalDragUpdate: (dragUpdate) {
                         

        //                   double tamanoTotalDelScrollSobreElHeightDelContainer = (_controller.position.maxScrollExtent) / 200;
        //                   // heightToMultiplier += aditionalSpace;
        //                    if(dragUpdate.globalPosition.dy + 40 > 200)
        //                     return;
        //                   _controller.position.moveTo((dragUpdate.globalPosition.dy + 40) * tamanoTotalDelScrollSobreElHeightDelContainer);

        //                   setState(() {
        //                      if(dragUpdate.globalPosition.dy >= 0) {
        //                        _offset = dragUpdate.globalPosition.dy;
        //                      }
        //                     print("View offset ${_controller.offset} scroll-bar offset ${_offset} _controller: ${_controller.position.maxScrollExtent}");
        //                   });
        //                 },
        //           ),
        //         )
        //     ),
        //   ],
        // ),
      //   child: Stack(
      //   children: <Widget>[
      //     Container(
      //       height: 2000,
      //     ),
      //     DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
      //   ],
      // ),
        // child: 
        // MyScrollbar(
        //     widget:  MyTable(columns: ["Nombre", "Apellido"], rows: listaPersona.map((e) => [e["nombre"], e["apellido"]]).toList())
          
        // )
        // Container(
        //   height: 200,
        //   child: DraggableScrollbar(
        //     child: ListView(
        //       children: [
        //         // Container(
        //         //   height: MediaQuery.of(context).size.height,
        //         //   width: MediaQuery.of(context).size.width,
        //         //   color: Colors.red,
        //         // ),
        //         // Container(
        //         //   height: MediaQuery.of(context).size.height,
        //         //   width: MediaQuery.of(context).size.width,
        //         //   color: Colors.yellow,
        //         // ),
        //         // Container(
        //         //   height: MediaQuery.of(context).size.height,
        //         //   width: MediaQuery.of(context).size.width,
        //         //   color: Colors.greenAccent,
        //         // ),
        //         MyTable(columns: ["Nombre", "Apellido"], rows: listaPersona.map((e) => [e["nombre"], e["apellido"]]).toList())
        //       ],
        //     ),
        //   ),
        // ),
      
      // ),
    
    );
  }
}


class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        // left: position.dx,
        top: position.dy,
        child: Draggable(
          axis: Axis.vertical,
          data: widget.itemColor,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: 
          Container(
            width: 120.0,
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}










//Final Scrollbar test
class DraggableScrollbar extends StatefulWidget {
  const DraggableScrollbar({this.child});

  final Widget child;

  @override
  _DraggableScrollbarState createState() => new _DraggableScrollbarState();
}

class _DraggableScrollbarState extends State<DraggableScrollbar>
    with TickerProviderStateMixin {
  //this counts offset for scroll thumb for Vertical axis
  double _barOffset;
  // controller for the thing
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _barOffset = 0;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      print("_onVerticalDragUpdate: ${details.delta.dy}");
      if(_barOffset + details.delta.dy >= 0)
        _barOffset += details.delta.dy;
    });
  }

  void _animateSelectorBack() {
    if (mounted) {
      setState(() {
        _barOffset = animation.value;
      });
    }
  }

  void _verticalGoesBack(DragEndDetails details) {
    animationController.reset();

    animation = Tween<double>(begin: _barOffset, end: 300.0)
        .animate(animationController)
          ..addListener(_animateSelectorBack);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      widget.child,
      GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          // onVerticalDragEnd: _verticalGoesBack,
          child: Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: _barOffset),
              child: _buildScrollThumb())),
    ]);
  }

  Widget _buildScrollThumb() {
    return new Container(
      height: 40.0,
      width: 20.0,
      color: Colors.blue,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}