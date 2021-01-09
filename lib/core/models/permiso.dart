

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
import 'package:prestamo/core/models/entidad.dart';
import 'package:prestamo/core/models/garante.dart';
import 'package:prestamo/core/models/garantia.dart';
import 'package:prestamo/core/models/gastoprestamo.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';

class Permiso {
  int id;
  String descripcion;
  Entidad entidad;
  bool seleccionado;

  Permiso({this.id, this.descripcion, this.seleccionado, this.entidad});

  Permiso.fromMap(Map snapshot) :
        id = Utils.toInt(snapshot['id'].toString()) ?? 0,
        descripcion = snapshot['descripcion']?? '',
        entidad = (snapshot['entidad'] != null) ? Entidad.fromMap(Utils.parsedToJsonOrNot(snapshot['entidad'])) : null,
        seleccionado = snapshot['seleccionado']?? false

        ;



  toJson() {
    return {
      "id": (id != null) ? id : null,
      "descripcion": descripcion,
      "entidad": entidad,
      "seleccionado": seleccionado,
    };
  }
}