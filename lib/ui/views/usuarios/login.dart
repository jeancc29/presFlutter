import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/usuario.dart';
import 'package:prestamo/core/services/loginservice.dart';
import 'package:prestamo/core/services/userservice.dart';
import 'package:prestamo/ui/widgets/mybutton.dart';
import 'package:prestamo/ui/widgets/mybutton2.dart';
import 'package:prestamo/ui/widgets/mygradienticon.dart';
import 'dart:math';

import 'package:prestamo/ui/widgets/myresizedcontainer.dart';
import 'package:prestamo/ui/widgets/mysubtitle.dart';
import 'package:prestamo/ui/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';
import 'package:prestamo/core/classes/database.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    AppDatabase db;
  final _cargandoNotify = ValueNotifier<bool>(false);
  var _formKey = GlobalKey<FormState>();
  var _txtUsuario = TextEditingController();
  var _txtPassword = TextEditingController();
  bool _cargando = false;


  _navigateToHome(){
    Navigator.pushNamedAndRemoveUntil(context, "/clientes", (route) => true);
  }

  _acceder() async {
    if(_formKey.currentState.validate() == false)
      return;


    try {
      // setState(() => _cargando = true);
      _cargandoNotify.value = true;
      var parsed = await UserService.login(context: context, usuario: Usuario(usuario: _txtUsuario.text, password: _txtPassword.text));
      parsed["usuario"]["apiKey"] = parsed["apiKey"];
      //  LoginService.save(parsed: parsed, db: db);

      await compute(LoginService.save2, {"parsed": parsed, "db" : db});
      // await Utils.showAlertDialog(context: context, content: "Despues de guardar los datos", title: "Despues");
      _cargandoNotify.value = false;
      // setState(() => _cargando = false);
      _navigateToHome();
    } on Exception catch (e) {
          // TODO
      // setState(() => _cargando = false);
      print("error acceder: ${e}");
      _cargandoNotify.value = false;

    }
  }

  _accederNotify() async {
    if(_formKey.currentState.validate() == false)
      return;


    try {
      // setState(() => _cargando = true);
      _cargandoNotify.value = true;
      var parsed = await UserService.login(context: context, usuario: Usuario(usuario: _txtUsuario.text, password: _txtPassword.text));
      parsed["usuario"]["apiKey"] = parsed["apiKey"];
      // await LoginService.save(parsed: parsed, db: db);
      // setState(() => _cargando = false);
      await compute(LoginService.save2, {"parsed": parsed, "db" : db});

      _cargandoNotify.value = false;

      _navigateToHome();
    } on Exception catch (e) {
          // TODO
      // setState(() => _cargando = false);
      print("error acceder: ${e}");
      _cargandoNotify.value = false;

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    db = Provider.of<AppDatabase>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cargandoNotify.dispose();
    _txtPassword.dispose();
    _txtUsuario.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      print("_login build");
    return Scaffold(
      
      body: Container(
        color: Colors.white,
        // decoration:  BoxDecoration(
        //   // color: const Color(0xff7c94b6),
        //   // color: Colors.grey,
        //   image: DecorationImage(
        //     // colorFilter: new ColorFilter.mode(Colors.red, BlendMode.dstATop),
        //       colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(0.3), BlendMode.lighten),
        //       image: NetworkImage(
        //           // "https://miro.medium.com/max/1068/1*b2cuG4QxzilzCduG31Rlzw.png",
        //           "http://loteriasdo.gq/assets/img/login.jpg",
        //         ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
          child: Column(
            children: [
              Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(icon: Icon(Icons.clear, color: Colors.grey, size: 25,), onPressed: (){}),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                      child: MyButton(
                        xlarge: 9,
                        type: MyButtonType.roundedWithOnlyBorder,
                        title: "Registrar",
                        padding: EdgeInsets.all(15),
                        function: (){},
                      ),
                    ),
                  )
                ],
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: MyResizedContainer(
                    medium: 1.5,
                    large: 2,
                    xlarge: 3.5,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(20))
                      // ),
                      child: Wrap(
                        children: [
                          // Align(
                          //   child: ,
                          // )
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 8.0, right: 20),
                          //     child: Container(
                          //       width: 60,
                          //       height: 60,
                          //       child:  ClipRRect(
                          //         borderRadius: BorderRadius.circular(20),
                          //         child: Container(
                          //           child: Align(
                          //             alignment: Alignment.topLeft,
                          //             widthFactor: 0.75,
                          //             heightFactor: 0.75,
                          //             child: Image(image: AssetImage('images/creditcard.png'), ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MySubtitle(title: "Acceder", fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 0,),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyTextFormField(
                              type: MyType.rounded,
                              isRequired: true,
                              controller: _txtUsuario,
                              hint: "Usuario",
                              title: "Usuario",
                              medium: 1,
                              large: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyTextFormField(
                              type: MyType.rounded,
                              isRequired: true,
                              hint: "Password",
                              isPassword: true,
                              controller: _txtPassword,
                              title: "Password",
                              medium: 1,
                              large: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton(
                            cargandoNotify: _cargandoNotify,
                            type: MyButtonType.rounded,
                            medium: 1,
                            padding: EdgeInsets.all(15),
                            function: _acceder, 
                            title: "Acceder",
                            
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: MyButton(
                          //   // cargando: _cargando,
                          //   color: Colors.yellow,
                          //   cargando2: _cargandoNotify,
                          //   type: MyButtonType.rounded,
                          //   medium: 1,
                          //   padding: EdgeInsets.all(15),
                          //   function: _accederNotify, 
                          //   title: "Acceder notify",
                            
                          //   ),
                          // ),
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("O", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey)),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          Wrap(
                            children: [
                              MyButton(
                                xlarge: 7,
                                medium: 2,
                                type: MyButtonType.roundedWithOnlyBorder,
                                // leading: FaIcon(FontAwesomeIcons.facebookF, color: Utils.colorPrimaryBlue,),
                                leading: Image(
                                  // image: NetworkImage("http://d35aaqx5ub95lt.cloudfront.net/images/facebook-blue.svg")
                                  image: AssetImage('images/facebook-blue.svg')
                                ),
                                title: "Facebook",
                                padding: EdgeInsets.all(15),
                                function: (){},
                              ),
                              MyButton(
                                xlarge: 7,
                                medium: 2,
                                type: MyButtonType.roundedWithOnlyBorder,
                                leading: Image(
                                  // image: NetworkImage("http://d35aaqx5ub95lt.cloudfront.net/images/google-color.svg"),
                                  image: AssetImage('images/google-color.svg')
                                ),
                                // leading: MyGradientIcon(
                                //   icon: FontAwesomeIcons.google, 
                                //   gradient: LinearGradient(
                                //     colors: [
                                //       Colors.red,
                                //       Colors.yellow,
                                //       Colors.blue,
                                //     ],
                                //     begin: Alignment.topLeft,
                                //     end: Alignment.bottomRight
                                //   ),
                                // ),
                                title: "Google",
                                padding: EdgeInsets.all(15),
                                function: (){},
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                Text("Al registrarte en Duolingo, aceptas nuestros", style: TextStyle(fontFamily: "GoogleSans")),
                                InkWell(onTap: (){}, child: Text("Términos", style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w700))),
                                Text(" y", style: TextStyle(fontFamily: "GoogleSans")),
                                Center(child: InkWell(onTap: (){}, child: Text("Política de privacidad", style: TextStyle(fontFamily: "GoogleSans", fontWeight: FontWeight.w700)))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      )
      
//        Container(
//         decoration: 
//         (true)
//         ?
//         BoxDecoration(
//   // color: const Color(0xff7c94b6),
//   color: const Color(0xff7c94b6),
//   image: new DecorationImage(
//     fit: BoxFit.cover,
//     // colorFilter: 
//       // ColorFilter.mode(Colors.black.withOpacity(0.5), 
//       // BlendMode.dstATop),
//   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.001),BlendMode.dstATop),
//     image: new NetworkImage(
//       'https://www.baseballprospectus.com/wp-content/uploads/2018/05/baseball-bruised.jpg',
//     ),
//   ),
// )
// :
//         BoxDecoration(
//           // color: const Color(0xff7c94b6),
//           // color: Colors.grey,
//           image: DecorationImage(
//             // colorFilter: new ColorFilter.mode(Colors.red, BlendMode.dstATop),
//               image: NetworkImage(
//                   "https://miro.medium.com/max/1068/1*b2cuG4QxzilzCduG31Rlzw.png",
//                 ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // child: ColorFiltered(
//           //   colorFilter: ColorFilter.mode(Colors.red.withOpacity(0.4), BlendMode.srcOver),
          
//           // ),
//         ),

      // body: Container(
      //   child: ShaderMask(
      //     shaderCallback: (rect) {
      //       return LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [Colors.black, Colors.transparent],
      //       ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      //     },
      //     blendMode: BlendMode.dstIn,
      //     child: Image.asset(
      //       'images/login.png',
      //       height: 400,
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      // ),
    );
  }
}

Widget ImageFilter({brightness, saturation, hue, child}) {
  return ColorFiltered(
    colorFilter: ColorFilter.matrix(
      ColorFilterGenerator.brightnessAdjustMatrix(
        value: brightness,
      )
    ),
    child: ColorFiltered(
      colorFilter: ColorFilter.matrix(
        ColorFilterGenerator.saturationAdjustMatrix(
          value: saturation,
        )
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(
          ColorFilterGenerator.hueAdjustMatrix(
            value: hue,
          )
        ),
        child: child,
      )
    )
  );
}


class ColorFilterGenerator {
    static List<double> hueAdjustMatrix({double value}) {
      value = value * pi;

      if (value == 0)
        return [
          1,0,0,0,0,
          0,1,0,0,0,
          0,0,1,0,0,
          0,0,0,1,0,
        ];

      double cosVal = cos(value);
      double sinVal = sin(value);
      double lumR = 0.213;
      double lumG = 0.715;
      double lumB = 0.072;

      return List<double>.from(<double>[
        (lumR + (cosVal * (1 - lumR))) + (sinVal * (-lumR)), (lumG + (cosVal * (-lumG))) + (sinVal * (-lumG)), (lumB + (cosVal * (-lumB))) + (sinVal * (1 - lumB)), 0, 0, (lumR + (cosVal * (-lumR))) + (sinVal * 0.143), (lumG + (cosVal * (1 - lumG))) + (sinVal * 0.14), (lumB + (cosVal * (-lumB))) + (sinVal * (-0.283)), 0, 0, (lumR + (cosVal * (-lumR))) + (sinVal * (-(1 - lumR))), (lumG + (cosVal * (-lumG))) + (sinVal * lumG), (lumB + (cosVal * (1 - lumB))) + (sinVal * lumB), 0, 0, 0, 0, 0, 1, 0,
      ]).map((i) => i.toDouble()).toList();
    }

    static List<double> brightnessAdjustMatrix({double value}) {
      if (value <= 0)
        value = value * 255;
      else value = value * 100;

      if (value == 0)
        return [
          1,0,0,0,0,
          0,1,0,0,0,
          0,0,1,0,0,
          0,0,0,1,0,
        ];

      return List<double>.from(<double>[
        1, 0, 0, 0, value, 0, 1, 0, 0, value, 0, 0, 1, 0, value, 0, 0, 0, 1, 0
      ]).map((i) => i.toDouble()).toList();
    }

    static List<double> saturationAdjustMatrix({double value}) {
      value = value * 100;

      if (value == 0)
        return [
          1,0,0,0,0,
          0,1,0,0,0,
          0,0,1,0,0,
          0,0,0,1,0,
        ];

      double x = ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();
      double lumR = 0.3086;
      double lumG = 0.6094;
      double lumB = 0.082;

      return List<double>.from(<double>[
        (lumR * (1 - x)) + x, lumG * (1 - x), lumB * (1 - x),
        0, 0,
        lumR * (1 - x),
        (lumG * (1 - x)) + x,
        lumB * (1 - x),
        0, 0,
        lumR * (1 - x),
        lumG * (1 - x),
        (lumB * (1 - x)) + x,
        0, 0, 0, 0, 0, 1, 0,
      ]).map((i) => i.toDouble()).toList();
    }
}