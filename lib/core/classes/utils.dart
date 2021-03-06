import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui';

import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestamo/core/classes/screensize.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/sucursal.dart';

class  Utils {
  // static final String URL = 'https://loteriasdo.cf';
  // static final String URL_SOCKET = 'http://192.168.43.63:3000';
  // static final String URL = 'https://pruebass.ml';
  static final String URL = 'http://127.0.0.1:8000';

  // static final String URL = 'https://loteriasdo.gq';
  // static final String URL_SOCKET = URL.replaceFirst("https", "http") + ":3000";
  
  static const Map<String, String> header = {
      // 'Content-type': 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
    'Accept': 'application/json',
  };

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Map<int, Color> color =
  {
    50:Color.fromRGBO(9,144,208, .1),
    100:Color.fromRGBO(9,144,208, .2),
    200:Color.fromRGBO(9,144,208, .3),
    300:Color.fromRGBO(9,144,208, .4),
    400:Color.fromRGBO(9,144,208, .5),
    500:Color.fromRGBO(9,144,208, .6),
    600:Color.fromRGBO(9,144,208, .7),
    700:Color.fromRGBO(9,144,208, .8),
    800:Color.fromRGBO(9,144,208, .9),
    900:Color.fromRGBO(9,144,208, 1),
  };

  static MaterialColor colorMaterialCustom = MaterialColor(0xFF0990D0, Utils.color);
  static Color colorPrimaryBlue = Utils.fromHex("#1170ec");
  static Color colorPrimary = fromHex("#38B6FF");
  static Color colorInfo = fromHex("#00bcd4");
  static Color colorInfoClaro = fromHex("4D00BCD4");
  static Color colorRosa = fromHex("#ffcccc");
  static Color colorGris = fromHex("#eae9e9");


  static Color colorGreyFromPairIndex({int idx}){
    if(idx % 2 != 0)
      return colorGris;
    else
      return Colors.transparent;
  }



  static Future<String> createJwt(Map<String, dynamic> data) async {
    var builder = new JWTBuilder();
    var token = builder
      // ..issuer = 'https://api.foobar.com'
      // ..expiresAt = new DateTime.now().add(new Duration(minutes: 1))
      ..setClaim('datosMovil', 
      // {'id': 836, 'username' : "john.doe"}
      data
      )
      ..getToken(); // returns token without signature

    // var signer = new JWTHmacSha256Signer('culo');
    // var c = await DB.create();
    // var apiKey = await c.getValue("apiKey");
    // print("Before error: $apiKey");
    // var signer = new JWTHmacSha256Signer(await c.getValue("apiKey"));
    var signer = new JWTHmacSha256Signer("7g654GPrRCrZPbJTiuDtELvaY1WJlHz2");
    var signedToken = builder.getSignedToken(signer);
    print(signedToken); // prints encoded JWT
    var stringToken = signedToken.toString();

    return stringToken;
  }

  static showSnackBar({String content, scaffoldKey}){
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(content),
        elevation: 25,
        action: SnackBarAction(label: 'CERRAR', onPressed: () => scaffoldKey.currentState.hideCurrentSnackBar(),),
      ));
  }

  static showAlertDialog({String content, String title, BuildContext context}){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  static dynamic parseDatos(String responseBody) {
    final parsed = json.decode(responseBody);
    // print('utils.parseDatos: $responseBody');
    return parsed;
    // parsed['bancas'].map<Banca>((json) => Banca.fromMap(json)).toList();
    // return parsed.map<Banca>((json) => Banca.fromMap(json)).toList();
    // return true;
  }

  static Map<String, dynamic> parsedToJsonOrNot(dynamic responseBody) {
    return (responseBody is String) ? json.decode(responseBody).cast<String, dynamic>() : responseBody;
  }

  static toDouble(String caracter){
    try {
      if(caracter.length > 0)
        caracter = caracter.replaceAll(",", '');
       return double.parse(caracter);
    } catch (e) {
      return 0.0;
    }
  }

  static double redondear(numero, [decimales = 2]){
    return double.parse((numero).toStringAsFixed(decimales));
  }

  static toInt(String caracter){
    try {
       return int.parse(caracter);
    } catch (e) {
      return 0;
    }
  }

  static Future<Uint8List> blobfileToUint(html.File file) async {
      Uint8List image;
      html.FileReader reader =  html.FileReader();
        reader.readAsArrayBuffer(file);
        await for(final a in reader.onLoadEnd){
          image = reader.result;
          return image;
        }

        return image;
    }

  static Container getClienteFoto(Cliente cliente, {size: 130, radius: 10}) {
    if(cliente.foto != null ){
      return Container(
          // color: Colors.blue,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              // color: Colors.blue,
              child: Image.memory(cliente.foto)
            ),
          ),
        );
      //  return Image.memory(await Utils.blobfileToUint(cliente.foto));
    }else{
      return Container(
          // color: Colors.red,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              child: Image(image: AssetImage('images/profile2.jpg'), )
            ),
          ),
        );
    }

    
    // return  Image(image: AssetImage('images/profile2.jpg'), );
  }
  static Container getSucursalFoto(Sucursal sucursal, {size: 130, radius: 10}) {
    if(sucursal.foto != null ){
      return Container(
          // color: Colors.blue,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              // color: Colors.blue,
              child: Image.memory(sucursal.foto)
            ),
          ),
        );
      //  return Image.memory(await Utils.blobfileToUint(cliente.foto));
    }else if(sucursal.nombreFoto != null){
      return Container(
          // color: Colors.red,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              child: FadeInImage(
                image: NetworkImage(
                    '${Utils.URL}/assets/perfil/${sucursal.nombreFoto}'),
                placeholder: AssetImage('images/profile2.jpg'),
              )
            ),
          ),
        );
    }else{
      return Container(
          // color: Colors.red,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              child: Image(image: AssetImage('images/profile2.jpg'), )
            ),
          ),
        );
    }

    
    // return  Image(image: AssetImage('images/profile2.jpg'), );
  }

  static Container getWidgetUploadFoto(dynamic sucursal, {size: 130, radius: 10}) {
    if(sucursal.foto != null ){
      return Container(
          // color: Colors.blue,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              // color: Colors.blue,
              child: Image.memory(sucursal.foto)
            ),
          ),
        );
      //  return Image.memory(await Utils.blobfileToUint(cliente.foto));
    }else if(sucursal.nombreFoto != null){
      return Container(
          // color: Colors.red,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              child: FadeInImage(
                image: NetworkImage(
                    '${Utils.URL}/assets/perfil/${sucursal.nombreFoto}'),
                placeholder: AssetImage('images/profile2.jpg'),
              )
            ),
          ),
        );
    }else{
      return Container(
          // color: Colors.red,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              child: Image(image: AssetImage('images/profile2.jpg'), )
            ),
          ),
        );
    }

    
    // return  Image(image: AssetImage('images/profile2.jpg'), );
  }

  static Future<bool> showDialogConfirmarEliminacion({@required BuildContext context, @required String title, @required descripcion}){
     
     return showDialog(context: context, builder: (context){
       _back({bool value = false}){
         Navigator.pop(context, value);
       }
       return StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
             title: Text("$title"),
             content: Text("$descripcion"),
             actions: [
               FlatButton(onPressed: _back, child: Text("Cancelar")),
               FlatButton(onPressed: () async {
                _back(value: true);
               }, child: Text("Ok")),
             ],
           );
         }
       );
     });
   }

  static toCurrency(var number){
    final formatCurrency = new NumberFormat.simpleCurrency();
    number = Utils.toDouble(number.toString());
    return formatCurrency.format(number).replaceFirst(".00", "");
  }

  static DateTime getLastDayOfMonth(DateTime date){
    if(date == null)
    date = new DateTime.now();
    // Find the last day of the month.
    var lastDayDateTime = (date.month < 12) ? new DateTime(date.year, date.month + 1, 0) : new DateTime(date.year + 1, 1, 0);

    // print(lastDayDateTime.day); // 28 for February
    return lastDayDateTime;
  }

  static DateTime getNextMonth(DateTime date, {int dayOfTheMonth, int monthsToAdd = 1}){
    DateTime nextMonth;
    if(date.day > 28 && dayOfTheMonth == null){
      DateTime nextMonthFirstDay = new DateTime(date.year, date.month + monthsToAdd, 1);
      DateTime nextMonthLastDay = getLastDayOfMonth(nextMonthFirstDay);
      nextMonth = (date.day > nextMonthLastDay.day) ? nextMonthLastDay : new DateTime(date.year, date.month + monthsToAdd, date.day);
    }
    else if(date.day >= 28 && dayOfTheMonth != null){
      DateTime nextMonthFirstDay = new DateTime(date.year, date.month + monthsToAdd, 1);
      DateTime nextMonthLastDay = getLastDayOfMonth(nextMonthFirstDay);
      nextMonth = (dayOfTheMonth > nextMonthLastDay.day) ? nextMonthLastDay : new DateTime(date.year, date.month + monthsToAdd, dayOfTheMonth);
    }
    else
      nextMonth = new DateTime(date.year, date.month + monthsToAdd, date.day);

    return nextMonth;
  }

   static Container getCustomerPhoto(String namePhoto, {size: 40, radius: 20}){
    return Container(
          // color: Colors.blue,
          width: size,
          height: size,
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              // color: Colors.blue,
              child: FadeInImage(
                image: NetworkImage(
                    '${Utils.URL}/assets/perfil/$namePhoto'),
                placeholder: AssetImage('images/profile2.jpg'),
              )
            ),
          ),
        );
    
  }

  static bool isSmallOrMedium(double size){
    return (ScreenSize.isMedium(size) || ScreenSize.isSmall(size));
  }

}