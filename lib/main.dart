import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamo/ui/router.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:timezone/data/latest.dart' as tz;




// void main() => runApp(Prueba2());

Future<void> main() async {
  // var path = Directory.current.path;
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
        // ChangeNotifierProvider(builder: (_) => locator<UnidadCRUD>()),
        // ChangeNotifierProvider(builder: (_) => locator<CRUDArticulo>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Product App',
        theme: ThemeData(
          fontFamily: 'OpenSans',
        ),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

//https://play.google.com/console/u/0/developers/8169340382790055454/inbox