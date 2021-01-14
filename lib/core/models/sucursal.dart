

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/trabajo.dart';

class Sucursal {
  BigInt id;
  // String foto;
  Uint8List foto;
  String nombreFoto;
  String nombre;
  String direccion;
  String ciudad;
  String telefono1;
  String telefono2;
  String gerenteSucursal;
  String gerenteCobro;
  bool status;

  Sucursal({this.id, this.foto, this.nombre, this.direccion, this.ciudad, this.telefono1, this.telefono2, this.status, this.nombreFoto});

  Sucursal.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        // foto = (snapshot['foto'] != null) ? base64Decode(snapshot['foto']) : null,
        nombreFoto = snapshot['foto'] ?? '',
        nombre = snapshot['nombre'] ?? '',
        direccion = snapshot['direccion'] ?? '',
        ciudad = snapshot['ciudad'] ?? '',
        telefono1 = snapshot['telefono1'] ?? '',
        telefono2 = snapshot['telefono2'] ?? '',
        gerenteSucursal = snapshot['gerenteSucursal'] ?? '',
        gerenteCobro = snapshot['gerenteCobro'] ?? '',
        status = (snapshot['status'] == 1) ? true : false ?? false
        ;



  static List<Referencia> referenciasToMap(List<dynamic> referencias){
    if(referencias != null)
      return referencias.map((data) => Referencia.fromMap(data)).toList();
    else
      return [];
  }

  // static List<Sucursal> SucursalSuperpaleToMap(List<dynamic> Sucursals){
  //   if(Sucursals != null)
  //     return Sucursals.map((data) => Sucursal.fromMap(data)).toList();
  //   else
  //     return List<Sucursal>();
  // }

  toJson() {
    return {
      "id": (id != null) ? id.toInt() : null,
      "foto": (foto != null) ? base64Encode(foto) : null,
      "nombre": nombre,
      "nombreFoto": nombreFoto,
      "direccion": direccion,
      "status": status,
      "ciudad": ciudad,
      "telefono1": telefono1,
      "telefono2": telefono2,
      "gerenteSucursal": gerenteSucursal,
      "gerenteCobro": gerenteCobro,
    };
  }
}