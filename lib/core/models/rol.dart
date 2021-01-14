

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

class Rol {
  int id;
  String descripcion;
  String permisosString;
  List<Permiso> permisos;

  Rol({this.id, this.descripcion, this.permisos});

  Rol.fromMap(Map snapshot) :
        id = Utils.toInt(snapshot['id'].toString()) ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        permisosString = snapshot['permisosString'] ?? '',
        permisos = (snapshot['permisos'] == null) ? [] : permisosToMap(snapshot['permisos'] is String ? Utils.parseDatos(snapshot["permisos"]) :snapshot['permisos']) ?? []
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
    if(permisos != null && permisos.length > 0)
      return permisos.map((data) => Permiso.fromMap(data)).toList();
    else
      return [];
  }

  // static List<Prestamo> PrestamoSuperpaleToMap(List<dynamic> Prestamos){
  //   if(Prestamos != null)
  //     return Prestamos.map((data) => Prestamo.fromMap(Utils.parsedToJsonOrNot(data)).toList();)
  //   else
  //     return List<Prestamo>();
  // }

  toJson() {
    return {
      "id": (id != null) ? id.toInt() : null,
      "descripcion": descripcion,
      "permisos": permisosToJson(),
    };
  }
}