

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/moneda.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/models/trabajo.dart';

class Empresa {
  BigInt id;
  // String foto;
  Uint8List foto;
  String nombreFoto;
  String nombre;
  Tipo tipoMora;
  String porcentajeMora;
  int diasGracia;
  Moneda moneda;
  int status;
  int idDireccion;
  Direccion direccion;
  int idContacto;
  Contacto contacto;

  Empresa({this.id, this.foto, this.nombre, this.tipoMora, this.porcentajeMora, this.diasGracia, this.moneda, this.status, this.idDireccion, this.direccion, this.idContacto, this.contacto, this.nombreFoto});

  Empresa.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        foto = (snapshot['foto'] != null) ? base64Decode(snapshot['foto']) : null,
        nombreFoto = snapshot['nombreFoto'] ?? '',
        nombre = snapshot['nombre'] ?? '',
        tipoMora = (snapshot['tipoMora'] != null) ? Tipo.fromMap(snapshot['tipoMora']) : null,
        porcentajeMora = Utils.toDouble(snapshot['porcentajeMora'].toString()) ?? 0,
        diasGracia = snapshot['diasGracia'] ?? 0,
        moneda = (snapshot['moneda'] != null) ? Moneda.fromMap(snapshot['moneda']) : null,
        status = snapshot['status'] ?? 1,
        idDireccion = snapshot['idDireccion'] ?? 0,
        direccion = (snapshot['direccion'] != null) ? Direccion.fromMap(snapshot['direccion']) : null,
        idContacto = snapshot['idContacto'] ?? 0,
        contacto = (snapshot['contacto'] != null) ? Contacto.fromMap(snapshot['contacto']) : null
        ;

  static List<Referencia> referenciasToMap(List<dynamic> referencias){
    if(referencias != null)
      return referencias.map((data) => Referencia.fromMap(data)).toList();
    else
      return List<Referencia>();
  }

  // static List<Empresa> EmpresaSuperpaleToMap(List<dynamic> Empresas){
  //   if(Empresas != null)
  //     return Empresas.map((data) => Empresa.fromMap(data)).toList();
  //   else
  //     return List<Empresa>();
  // }

  toJson() {
    return {
      "id": (id != null) ? id.toInt() : null,
      "foto": (foto != null) ? base64Encode(foto) : null,
      "nombreFoto": nombreFoto,
      "nombre": nombre,
      "tipoMora": tipoMora,
      "status": status,
      "porcentajeMora": porcentajeMora,
      "diasGracia": diasGracia,
      "moneda": moneda,
      "idDireccion": idDireccion,
      "direccion": direccion,
      "idContacto": idContacto,
      "contacto": (contacto != null) ? contacto.toJson() : null,
    };
  }
}