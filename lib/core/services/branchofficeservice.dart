import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/models/sucursal.dart';


class BranchofficeService{
  static Future<Map<String, dynamic>> index({BuildContext context, scaffoldKey}) async {
    var map = Map<String, dynamic>();
    // map["servidor"] = await Db.servidor();
    // var jwt = await Utils.createJwt(map);

    var response = await http.get(Utils.URL + "/api/branchoffices", headers: Utils.header);
    int statusCode = response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      print("BranchofficeService index: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      if(context != null)
        Utils.showAlertDialog(context: context, content: "Error del servidor BranchofficeService index ${parsed["message"]}", title: "Error");
      else
        Utils.showSnackBar(content: "Error del servidor BranchofficeService index ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error del servidor BranchofficeService index");
    }

    var parsed = await compute(Utils.parseDatos, response.body);
    if(parsed["errores"] == 1){
      if(context != null)
        Utils.showAlertDialog(context: context, content: parsed["mensaje"], title: "Error");
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error BranchofficeService index: ${parsed["mensaje"]}");
    }

    return parsed;
  }
  
  static Future<Map<String, dynamic>> store({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Sucursal sucursal}) async {
    var map = Map<String, dynamic>();
    // sucursal.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = sucursal.toJson();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/branchoffices/store", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor BranchofficeService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error BranchofficeService guardar: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error BranchofficeService guardar: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor BranchofficeService guardar: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("BranchofficeService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error BranchofficeService all");
    }


    return parsed;
  }

  static Future<Map<String, dynamic>> delete({BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, Sucursal sucursal}) async {
    var map = Map<String, dynamic>();
    // cliente.toJson();
    // map["servidor"] = await Db.servidor();
    map["data"] = sucursal.toJson();
    Map<String, dynamic> map2 = Map<String, dynamic>();
    // map2["data"] = map;
    // print("map: ${map}");
    // var jwt = await Utils.createJwt(map);
    var response = await http.post(Utils.URL + "/api/branchoffices/delete", body: json.encode(map), headers: Utils.header);
    int statusCode =response.statusCode;

    if(statusCode < 200 || statusCode > 400){
      // print("Servidor BranchofficeService all: ${response.body}");
      var parsed = await compute(Utils.parseDatos, response.body);
      print("Error: ${parsed}");
      if(context != null)
        Utils.showAlertDialog(content: "Error BranchofficeService delete: ${parsed["message"]}", title: "Error", context: context);
      else
        Utils.showSnackBar(content: "Error BranchofficeService delete: ${parsed["message"]}", scaffoldKey: scaffoldKey);
      throw Exception("Error Servidor BranchofficeService delete: ");
    }

    var parsed = await compute(Utils.parseDatos, response.body);

    if(parsed["errores"] == 1){
      print("BranchofficeService error all: ${parsed["mensaje"]}");
      if(context != null)
        Utils.showAlertDialog(content: parsed["mensaje"], title: "Error", context: context);
      else
        Utils.showSnackBar(content: parsed["mensaje"], scaffoldKey: scaffoldKey);
      throw Exception("Error BranchofficeService delete");
    }


    return parsed;
  }

}