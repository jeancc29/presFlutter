import 'package:flutter/material.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/ui/widgets/mydatepicker.dart';
import 'package:prestamo/ui/widgets/mydropdownbutton.dart';
import 'package:prestamo/ui/widgets/myexpansiontile.dart';
import 'package:prestamo/ui/widgets/mylisttile.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';

class ClientesAdd extends StatefulWidget {
  @override
  _ClientesAddState createState() => _ClientesAddState();
}

class _ClientesAddState extends State<ClientesAdd> with TickerProviderStateMixin {
  ScrollController _scrollController;
  var _txtDocumento = TextEditingController();
  var _txtNombres = TextEditingController();
  var _txtApellidos = TextEditingController();
  var _txtApodo = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _fechaNacimiento = DateTime.now();
  var _tabController;
  bool _cargando = false;
  // var _controller = TabController(initialIndex: 0)

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer( child: ListView(children: [
      //   ListTile(
      //     leading: Icon(Icons.home),
      //     title: Text("Inicio"),
      //   )
      // ],),),
      appBar: AppBar(
        
        title: Row(children: [
         
          IconButton(icon: Icon(Icons.menu, color: Colors.black), onPressed: (){},),
          //  Padding(
          //       padding: const EdgeInsets.only(top: 2.0, right: 2),
          //       child: Container(
          //         width: 60,
          //         height: 60,
          //         child:  Container(
          //           child: Image(image: AssetImage('images/p1_sin_fondo.png'), ),
          //         ),
          //       ),
          //     ),
          
          Text("Prestamo", style: TextStyle(color: Colors.black),),
          Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 60,
                  height: 60,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        widthFactor: 0.75,
                        heightFactor: 0.75,
                        child: Image(image: AssetImage('images/p7.jpeg'), ),
                      ),
                    ),
                  ),
                ),
              ),
        ],),
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.black
        // ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Visibility(
                    visible: _cargando,
                    child: Theme(
                      data: Theme.of(context).copyWith(accentColor: Utils.colorPrimary),
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.info_outline, color: Colors.black,),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.help_outline, color: Colors.black,),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none, color: Colors.black,),
          ),
        ],
      ),
      body: Row(children: [
        Visibility(
          visible: MediaQuery.of(context).size.width > ScreenSize.md,
          child: Container(
            // color: Colors.red,
            width: 260,
            height: MediaQuery.of(context).size.height,
            child: ListView(children: [
              SizedBox(height: 5,),
              // Row(
              //   children: [
              //   Padding(
              //     padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //     child: Icon(Icons.apps, color: Colors.black,),
              //   ),
              //   Text("Todas las apps", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), ),),
              // ],),
              // Container(
              //   color: Colors.transparent,
              //   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Row(
              //     children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //       child: Icon(Icons.apps, color: Colors.black,),
              //     ),
              //     Text("Todas las apps", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), ),),
              //   ],),
              // ),
              // Container(
              //   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   decoration: BoxDecoration(
              //     color: Colors.blue[50],
              //     borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              //   ),
              //   child: Row(
              //     children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 28.0, right: 14, top: 2.0),
              //       child: Icon(Icons.tablet_mac, color: Utils.fromHex("#1a73e8"),),
              //     ),
              //     Text("Recibidos", style: TextStyle(fontSize: 14, color: Utils.fromHex("#1a73e8"), fontWeight: FontWeight.bold ),),
              //   ],),
              // ),
              MyListTile(title: "Todas las apps", icon: Icons.apps),
              MyListTile(title: "Recibido", icon: Icons.tablet_mac),
              // MyListTile(title: "CUlo", icon: Icons.recent_actors),
              MyListTile(title: "Usuarios y permisos", icon: Icons.recent_actors),
              MyListTile(title: "Administracion de pedidos", icon: Icons.payment, selected: true,),
              MyExpansionTile(
                title: "Descargar informes", 
                icon: Icons.file_download, 
                listaMylisttile: [MyListTile(title: "Comentarios", icon: null), MyListTile(title: "Estadisticas", icon: null)]
              )
            ],),
          ),
        ),
        Expanded(
          child: ListView(
            // color: Colors.blue,
            children: [
              // Container(
              //   decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
              //   child: new TabBar(
              //     controller: _controller,
              //     tabs: [
              //       new Tab(
              //         icon: const Icon(Icons.home),
              //         text: 'Address',
              //       ),
              //       new Tab(
              //         icon: const Icon(Icons.my_location),
              //         text: 'Location',
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Clientes", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 3.0),
                    child: Text("Todos los datos para agregar o editar clientes", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                  ),
                  InkWell(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),

                      child: Text("Ver mas", style: TextStyle(color: Utils.colorPrimaryBlue)),
                    ),
                    onTap: (){},
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  // decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelStyle: TextStyle(color: Utils.colorPrimaryBlue),
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    labelColor: Utils.colorPrimaryBlue,
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
                        child: Text('Mensajes',),
                        
                      ),
                      new Tab(
                        // icon: const Icon(Icons.my_location),
                        child: Text('Mensajes archivados',),
                      ),
                    ],
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, boxConstraints) {
                  return new Container(
                    height: 200,
                    child: new TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                          child: Scrollbar(
                            controller: _scrollController,
                            
                            isAlwaysShown: true,
                            child: ListView(
                              controller: _scrollController,
                              children: [
                              Form(
                                key: _formKey,
                                child: LayoutBuilder(
                                  builder: (context, boxconstrains) {
                                    return Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyDropdownButton(
                                            screenSize: boxconstrains.maxWidth, 
                                            title: "Tipo Doc.", 
                                            onChanged: (data){

                                            }, 
                                            elements: ["Cedula de identidad", "RNC"],
                                            medium: 2,
                                            xlarge: 4,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new MyTextFormField(title: "Documento", controller: _txtDocumento, hint: "Documento", screenSize: boxconstrains.maxWidth, medium: 2)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyTextFormField(title: "Nombres", controller: _txtNombres, hint: "Nombres", screenSize: boxconstrains.maxWidth,)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyTextFormField(title: "Apellidos", controller: _txtApellidos, hint: "Apellidos", screenSize: boxconstrains.maxWidth,)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyTextFormField(title: "Apodo", controller: _txtApodo, hint: "Apodo", screenSize: boxconstrains.maxWidth,)
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: MyDatePicker(title: "Fecha Naci.", fecha: _fechaNacimiento, onDateTimeChanged: (newDate) => setState(() => _fechaNacimiento = newDate),),
                                        ),
                                        
                                        // Column(children: [
                                        //   Text("Documento", style: TextStyle(color: Colors.red),),
                                        //   Container(
                                        //     child: TextFormField(
                                        //       controller: _txtDocumento,
                                        //         decoration: InputDecoration(
                                        //           labelText: "Docuemnto"
                                        //         ),
                                        //       ),
                                        //   )
                                        // ],)
                                      ],
                                    );
                                  }
                                ),
                              )
                            ],),
                          ),
                        ),
                        new Card(
                          child: new ListTile(
                            leading: const Icon(Icons.location_on),
                            title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
                            trailing: new IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
        
      ],),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius}) : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = false;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(cfg.size.width / 2, cfg.size.height - radius);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: circleOffset, height: cfg.size.height / 9, width: cfg.size.width), Radius.circular(5)), _paint);
    // canvas.drawCircle(circleOffset, radius, _paint);
  }
}