import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prestamo/ui/views/cajas/index.dart';
import 'package:prestamo/ui/views/clientes/add.dart';
import 'package:prestamo/ui/views/clientes/index.dart';
import 'package:prestamo/ui/views/gastos/add.dart';
import 'package:prestamo/ui/views/gastos/index.dart';
import 'package:prestamo/ui/views/rutas/index.dart';



class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/' :
      //   return  MaterialPageRoute(
      //     builder: (_)=> ClientesScreen()
      //   );
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> CajasScreen()
        );
      case '/clientes' :
        return  MaterialPageRoute(
          builder: (_)=> ClientesScreen()
        );
      case '/rutas' :
        return  MaterialPageRoute(
          builder: (_)=> RutasScreen()
        );
      case '/gastos' :
        return  MaterialPageRoute(
          builder: (_)=> GastosScreen()
        );
      case '/AddGastos' :
        return  MaterialPageRoute(
          builder: (_)=> AddGastos(data: settings.arguments,)
        );
        // return  MaterialPageRoute(
        //   builder: (_)=> ClientesAdd()
        // );
        // return  MaterialPageRoute(
        //   builder: (_)=> SplashScreen()
        // );
        // case '/actualizar' :
        //   return MaterialPageRoute(
        //     builder: (_)=> ActualizarScreen(settings.arguments)
        //   ) ;
        // case '/transacciones' :
        //   return MaterialPageRoute(
        //     builder: (_)=> TransaccionesScreen()
        //   ) ;
        // case '/addTransacciones' :
        //   return MaterialPageRoute(
        //     builder: (_)=> AddTransaccionesScreen()
        //   ) ;
      // case '/' :
      //   return  MaterialPageRoute(
      //     builder: (_)=> SplashScreen()
      //   );
      // case '/' :
      //   return  MaterialPageRoute(
      //     builder: (_)=> PrincipalApp()
      //   );
      // case '/' :
      //   return MaterialPageRoute(
      //     builder: (_)=> PruebaApp()
      //   ) ;
      // case '/addArticulo' :
      //   return MaterialPageRoute(
      //     builder: (_)=> addArticulo()
      //   ) ;
      // case '/articulos' :
      //   return MaterialPageRoute(
      //     builder: (_)=> ArticulosApp()
      //   ) ;
      // case '/AddProyecto' :
      //   return MaterialPageRoute(
      //     builder: (_)=> AddProyecto()
      //   ) ;
      // case '/proyectos' :
      //   return MaterialPageRoute(
      //     builder: (_)=> ProyectosApp()
      //   ) ;
      // case '/addProduct' :
      //   return MaterialPageRoute(
      //     builder: (_)=> AddProduct()
      //   ) ;
      // case '/productDetails' :
      //   return MaterialPageRoute(
      //       builder: (_)=> ProductDetails()
      //   ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}