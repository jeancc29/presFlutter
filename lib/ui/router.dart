import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prestamo/ui/views/bancos/index.dart';
import 'package:prestamo/ui/views/cajas/index.dart';
import 'package:prestamo/ui/views/clientes/add.dart';
import 'package:prestamo/ui/views/clientes/index.dart';
import 'package:prestamo/ui/views/configuraciones/configuracionEmpresa.dart';
import 'package:prestamo/ui/views/configuraciones/configuracionPrestamoscreen.dart';
import 'package:prestamo/ui/views/cuentas/index.dart';
import 'package:prestamo/ui/views/gastos/add.dart';
import 'package:prestamo/ui/views/gastos/index.dart';
import 'package:prestamo/ui/views/prestamos/add.dart';
import 'package:prestamo/ui/views/prestamos/index.dart';
import 'package:prestamo/ui/views/prestamos/show.dart';
import 'package:prestamo/ui/views/pruebascroll.dart';
import 'package:prestamo/ui/views/pruebascroll2.dart';
import 'package:prestamo/ui/views/roles/roles.dart';
import 'package:prestamo/ui/views/rutas/index.dart';
import 'package:prestamo/ui/views/sucursales/add.dart';
import 'package:prestamo/ui/views/sucursales/index.dart';
import 'package:prestamo/ui/views/usuarios/addUser.dart';
import 'package:prestamo/ui/views/usuarios/login.dart';



class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        // return  MaterialPageRoute(
        //   builder: (_)=> ClientesScreen()
        // );
        return  MaterialPageRoute(
          builder: (_)=> LoginScreen()
        );
        // return  MaterialPageRoute(
        //   builder: (_)=> PruebaScroll2()
        // );
      case '/prestamos' :
        return  MaterialPageRoute(
          builder: (_)=> PrestamosScreen()
        );
      case '/showPrestamo' :
        return  MaterialPageRoute(
          builder: (_)=> ShowPrestamo(prestamo: settings.arguments,)
        );
      case '/addPrestamo' :
        return  MaterialPageRoute(
          builder: (_)=> PrestamoAddScreen()
        );
      case '/cajas' :
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
      case '/bancos' :
        return  MaterialPageRoute(
          builder: (_)=> BancosScreen()
        );
      case '/cuentas' :
        return  MaterialPageRoute(
          builder: (_)=> CuentasScreen()
        );
      case '/roles' :
        return  MaterialPageRoute(
          builder: (_)=> RolesScreen()
        );
      case '/usuarios' :
        return  MaterialPageRoute(
          builder: (_)=> AddUserScreen()
        );
      case '/sucursales' :
        return  MaterialPageRoute(
          builder: (_)=> SucursalesScreen()
        );
      case '/sucursales/add' :
        return  MaterialPageRoute(
          builder: (_)=> SucursalesAdd()
        );
      case '/configuracionPrestamo' :
        return  MaterialPageRoute(
          builder: (_)=> ConfiguracionPrestamoScreen()
        );
      case '/configuracionEmpresa' :
        return  MaterialPageRoute(
          builder: (_)=> ConfiguracionEmpresaScreen()
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