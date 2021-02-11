import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/ruta.dart';


class RouteService{
  static Future<Map<String, dynamic>> index({BuildContext context, scaffoldKey, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    map["data"] = await db.getUsuario();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    // var response = await http.get(Utils.URL + "/api/routes", headers: Utils.header);
    var response = await http.post(Utils.URL + "/api/routes", body: json.encode(map), headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("routeservice index: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor routeservice index ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor routeservice index ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor routeservice index");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error routeservice index: ${parsed["mensaje"]}");
    }

    return parsed;
  }

  static Future<Map<String, dynamic>> store({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Ruta ruta, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = ruta.toJson();
    map["data"]["usuario"] = await db.getUsuario();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/routes/store", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor RouteService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error RouteService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error RouteService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor RouteService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("RouteService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error RouteService all");
    }


    return parsed;
  }

  static Future<Map<String, dynamic>> delete({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Ruta ruta, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = ruta.toJson();
    map["data"]["usuario"] = await db.getUsuario();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/routes/delete", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor RouteService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error RouteService delete: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error RouteService delete: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor RouteService delete: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("RouteService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error RouteService delete");
    }


    return parsed;
  }
}