

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/amortizacion.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/cobrador.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/desembolso.dart';
import 'package:prestamo/core/models/dia.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/garante.dart';
import 'package:prestamo/core/models/garantia.dart';
import 'package:prestamo/core/models/gastoprestamo.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/permiso.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';

class Entidad {
  int id;
  String descripcion;
  List<Permiso> permisos;

  Entidad({this.id, this.descripcion});

  Entidad.fromMap(Map snapshot) :
        id = Utils.toInt(snapshot['id'].toString()) ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        permisos = permisosToMap(snapshot['permisos'] is String ? Utils.parseDatos(snapshot["permisos"]) :snapshot['permisos']) ?? []
        ;

  List permisosToJson() {

    List jsonList = [];
    if(permisos != null)
      permisos.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Permiso> permisosToMap(List<dynamic> permisos){
    if(permisos != null)
      return permisos.map((data) => Permiso.fromMap(data)).toList();
    else
      return [];
  }


  toJson() {
    return {
      "id": (id != null) ? id : null,
      "descripcion": descripcion,
    };
  }
}