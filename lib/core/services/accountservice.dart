import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/cuenta.dart';


class AccountService{
  static Future<Map<String, dynamic>> index({BuildContext context, scaffoldKey}) async {
    var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var response = await http.get(Utils.URL + "/api/accounts", headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("AccountService index: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor AccountService index ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor AccountService index ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor AccountService index");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error AccountService index: ${parsed["mensaje"]}");
    }

    return parsed;
  }
  static Future<Map<String, dynamic>> search({BuildContext context, scaffoldKey, @required String data}) async {
    var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var response = await http.get(Utils.URL + "/api/accounts/search?datos=$data", headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("AccountService search: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor AccountService search ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor AccountService search ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor AccountService search ${parsed["message"]}");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error AccountService search: ${parsed["mensaje"]}");
    }

    return parsed;
  }

  static Future<Map<String, dynamic>> store({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Cuenta cuenta}) async {
    var map = Map<String, dynamic>();
    // cuenta.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = cuenta.toJson();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/accounts/store", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor AccountService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error AccountService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error AccountService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor AccountService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("AccountService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error AccountService all");
    }


    return parsed;
  }

  static Future<Map<String, dynamic>> delete({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Cuenta cuenta}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = cuenta.toJson();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/accounts/delete", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor AccountService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error AccountService delete: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error AccountService delete: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor AccountService delete: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("AccountService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error AccountService delete");
    }


    return parsed;
  }

}