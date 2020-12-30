import 'package:flutter/material.dart';

class MyScrollbar extends StatefulWidget {
  final Widget child;
  final double height;
  MyScrollbar({Key key, this.child, this.height}) : super(key: key);

  @override
  _MyScrollbarState createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar> {
  ScrollController _controller;
  double oldScrollControllerHeight = 0;
  double _offset = 0;
  double scrollHeight = 40;
  static double screenHeight = 0;
  double posicionAnterior = 0;

  @override
  void initState() {
    _controller = ScrollController();
_controller.addListener(() { print("MyScrollbar SCrollchanged"); });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding: ${_controller.position.maxScrollExtent} screen: $screenHeight");
      oldScrollControllerHeight = _controller.position.maxScrollExtent;
      _calcularTamanoDelScrollWhenLoadAllWidget(tamanoScrollController: _controller.position.maxScrollExtent, tamanoPantalla: screenHeight);
    });
    super.initState();
  }

  _calcularTamanoDelScrollWhenLoadAllWidget({@required double tamanoScrollController, @required double tamanoPantalla}){
    double tamanoScrollToReturn = 40;
    double tamanoMitadDeLaPantalla = tamanoPantalla / 1.6;
    if(tamanoMitadDeLaPantalla > tamanoScrollController)
      tamanoScrollToReturn = tamanoPantalla - tamanoScrollController;
    // else if()
    // if(tamanoPantalla > tamanoScrollController)
    // double tmpScrollHeight = (tamanoScrollController / tamanoPantalla) != scrollHeight ? _controller.position.maxScrollExtent / boxconstraint.maxHeight : scrollHeight;
    print("MyScrollbar height: $tamanoScrollToReturn");
    setState(() => scrollHeight = tamanoScrollToReturn);
  }

  _calcularTamanoDelScroll(){
    if(!_controller.hasClients){
      return;
    }

    

    double tamanoScrollController = _controller.position.maxScrollExtent;
    print("MyScrollbar oldScrollHeight: $oldScrollControllerHeight newScrollHeight: $tamanoScrollController");
    if(oldScrollControllerHeight == tamanoScrollController)
      return;

    print("MyScrollbar inside oldScrollHeight: $oldScrollControllerHeight newScrollHeight: $tamanoScrollController");
    
    double tamanoPantalla = screenHeight;
    double tamanoScrollToReturn = 40;
    double tamanoMitadDeLaPantalla = tamanoPantalla / 1.6;
    if(tamanoMitadDeLaPantalla > tamanoScrollController)
      tamanoScrollToReturn = tamanoPantalla - tamanoScrollController;
    // else if()
    // if(tamanoPantalla > tamanoScrollController)
    // double tmpScrollHeight = (tamanoScrollController / tamanoPantalla) != scrollHeight ? _controller.position.maxScrollExtent / boxconstraint.maxHeight : scrollHeight;
     if(scrollHeight != tamanoScrollToReturn){
       scrollHeight = tamanoScrollToReturn;
       oldScrollControllerHeight = tamanoScrollController;
     }

      
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints boxconstraint) {
        screenHeight = boxconstraint.maxHeight;
       _calcularTamanoDelScroll();
       
        return Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: widget.child
                  ),
                ),
                //Scroll bar
                Container(
                    alignment: Alignment.centerRight,
                    // height: MediaQuery.of(context).size.height,
                    height: boxconstraint.maxHeight,
                    width: 20.0,
                    margin: EdgeInsets.only(left: boxconstraint.maxWidth - 20.0),
                    // decoration: BoxDecoration(color: Colors.black12),
                    child: Container(
                      alignment: Alignment.topCenter,
                        child: GestureDetector(
                            child: Container(
                            height: scrollHeight,
                            width: 5.0,
                            margin:
                                EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(3.0))),
                          ),
                            onVerticalDragUpdate: (dragUpdate) {
                              
                              // double tmpScrollHeight = _calcularTamanoDelScroll(tamanoScrollController: _controller.position.maxScrollExtent, tamanoPantalla: boxconstraint.maxHeight);
                              // print("positionAnterior: $posicionAnterior nueva: ${dragUpdate.globalPosition.dy}");
                              double tamanoTotalDelScrollSobreElHeightDelContainer = (_controller.position.maxScrollExtent) / boxconstraint.maxHeight;
                              // heightToMultiplier += aditionalSpace;
                              if((_offset + dragUpdate.delta.dy) + scrollHeight > boxconstraint.maxHeight)
                                return;
                              // _controller.position.moveTo((dragUpdate.globalPosition.dy + scrollHeight) * tamanoTotalDelScrollSobreElHeightDelContainer);
                              setState(() {
                                  print("offset: $_offset deltady: ${dragUpdate.delta.dy} +: ${_offset + dragUpdate.delta.dy}");
                                if(_offset >= 0){
                                  _offset += (_offset + dragUpdate.delta.dy >= 0) ? dragUpdate.delta.dy : 0;
                                  double calculo = (_offset + scrollHeight) * tamanoTotalDelScrollSobreElHeightDelContainer;
                                   _controller.position.moveTo(_offset == 0 ? 0 : calculo);
                                }else{
                                  // if(_controller.position.pixels > 0)  
                                  // _controller.position.moveTo(0);
                                }
                                //  if(dragUpdate.globalPosition.dy >= 0) {
                                //   //  _offset = dragUpdate.globalPosition.dy;
                                //    _offset += dragUpdate.delta.dy;
                                //    posicionAnterior = _offset;
                                //  }
                                //  if(tmpScrollHeight != scrollHeight)
                                //   scrollHeight = tmpScrollHeight;
                                // print("View offset ${_controller.offset} scroll-bar offset ${_offset} _controller: ${_controller.position.maxScrollExtent} screen: ${dragUpdate.globalPosition.distance}");
                              });
                            },
                      ),
                    )
                ),
              ],
            );
      }
    );
      
    
  }
}