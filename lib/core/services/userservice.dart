import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/models/usuario.dart';


class UserService{
  static Future<Map<String, dynamic>> index({BuildContext context, scaffoldKey, AppDatabase db}) async {
    // var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var map = Map<String, dynamic>();
    map["data"] = await db.getUsuario();

    // var response = await http.get(Utils.URL + "/api/users", headers: Utils.header);
    var response = await http.post(Utils.URL + "/api/users", body: json.encode(map), headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("UserService index: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor UserService index ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor UserService index ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor UserService index");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error UserService index: ${parsed["mensaje"]}");
    }

    return parsed;
  }
  static Future<Map<String, dynamic>> search({BuildContext context, scaffoldKey, @required String data}) async {
    var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var response = await http.get(Utils.URL + "/api/users/search?datos=$data", headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("UserService search: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor UserService search ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor UserService search ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor UserService search ${parsed["message"]}");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error UserService search: ${parsed["mensaje"]}");
    }

    return parsed;
  }

  static Future<Map<String, dynamic>> store({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Usuario usuario, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    // usuario.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = usuario.toJson();
    map["data"]["usuarioData"] = await db.getUsuario();

    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/users/store", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor UserService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error UserService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error UserService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor UserService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("UserService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error UserService all");
    }


    return parsed;
  }

  static Future<Map<String, dynamic>> login({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Usuario usuario}) async {
    var map = Map<String, dynamic>();
    // usuario.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = usuario.toJson();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/users/login", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor UserService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error UserService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error UserService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor UserService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("UserService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error UserService all");
    }


    return parsed;
  }

  static Future<Map<String, dynamic>> delete({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Usuario usuario, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = usuario.toJson();
    map["data"]["usuario"] = await db.getUsuario();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/users/delete", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor UserService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error UserService delete: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error UserService delete: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor UserService delete: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("UserService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error UserService delete");
    }


    return parsed;
  }

}