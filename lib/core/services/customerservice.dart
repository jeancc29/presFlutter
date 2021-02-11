import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prestamo/core/classes/database.dart';
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';


class CustomerService{
  static Future<Map<String, dynamic>> index({@required BuildContext context, scaffoldKey, @required AppDatabase db}) async {
    // var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var map = Map<String, dynamic>();
    map["data"] = await db.getUsuario();

    print("customerservice index: ${await db.getUsuario()}");
    // return {};
    // var response = await http.get(Utils.URL + "/api/customers?usuario=${json.encode(await db.getUsuario())}", headers: Utils.header);
    var response = await http.post(Utils.URL + "/api/customers", body: json.encode(map), headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("customerservice index: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor customerservice index ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor customerservice index ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor customerservice index");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error customerservice index: ${parsed["mensaje"]}");
    }

    return parsed;
  }
  static Future<Map<String, dynamic>> search({BuildContext context, scaffoldKey, @required String data, @required int idEmpresa}) async {
    var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var response = await http.get(Utils.URL + "/api/customers/search?datos=$data&idEmpresa=$idEmpresa", headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("customerservice search: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor customerservice search ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor customerservice search ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor customerservice search ${parsed["message"]}");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error customerservice search: ${parsed["mensaje"]}");
    }

    return parsed;
  }

  static Future<List<Cliente>> store({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Cliente cliente, AppDatabase db}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = cliente.toJson();
    map["data"]["usuario"] = await db.getUsuario();
    // print("CustomerService store: ${map}");
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/customers/store", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor CustomerService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error CustomerService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error CustomerService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor CustomerService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("CustomerService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error CustomerService all");
    }


    return (parsed["bancas"] != null) ? parsed["bancas"].map<Cliente>((json) => Cliente.fromMap(json)).toList() : List<Cliente>();
  }
}