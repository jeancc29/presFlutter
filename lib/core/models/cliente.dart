

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/trabajo.dart';

class Cliente {
  BigInt id;
  // String foto;
  Uint8List foto;
  String fotoEnlace;
  String nombres;
  String apellidos;
  String apodo;
  int numeroDependientes;
  DateTime fechaNacimiento;
  String sexo;
  String estadoCivil;
  String tipoVivienda;
  String tiempoEnVivienda;
  String referidoPor;
  int status;
  int idDireccion;
  Direccion direccion;
  int idContacto;
  Contacto contacto;
  int idDocumento;
  Documento documento;
  Trabajo trabajo;
  Negocio negocio;
  List<Referencia> referencias;

  String nacionalidad;

  Cliente({this.id, this.foto, this.nombres, this.apellidos, this.apodo, this.numeroDependientes, this.fechaNacimiento, this.sexo, this.estadoCivil, this.status, this.nacionalidad, this.idDireccion, this.direccion, this.idContacto, this.contacto, this.idDocumento, this.documento, this.trabajo, this.negocio, this.referencias, this.fotoEnlace});

  Cliente.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        foto = (snapshot['foto'] != null) ? base64Decode(snapshot['foto']) : null,
        // fotoEnlace = snapshot['foto'] ?? '',
        nombres = snapshot['nombres'] ?? '',
        apellidos = snapshot['apellidos'] ?? '',
        apodo = snapshot['apodo'] ?? '',
        numeroDependientes = snapshot['numeroDependientes'] ?? 0,
        fechaNacimiento = (snapshot['fechaNacimiento'] != null) ? DateTime.parse(snapshot['fechaNacimiento']) : null,
        sexo = snapshot['sexo'] ?? '',
        estadoCivil = snapshot['estadoCivil'] ?? '',
        status = snapshot['status'] ?? 1,
        nacionalidad= snapshot['nacionalidad'] ?? '',
        idDireccion = snapshot['idDireccion'] ?? 0,
        direccion = (snapshot['direccion'] != null) ? Direccion.fromMap(snapshot['direccion']) : null,
        idContacto = snapshot['idContacto'] ?? 0,
        contacto = (snapshot['contacto'] != null) ? Contacto.fromMap(snapshot['contacto']) : null,
        idDocumento = snapshot['idDocumento'] ?? 0,
        documento = (snapshot['documento'] != null) ? Documento.fromMap(snapshot['documento']) : null,
        trabajo = (snapshot['trabajo'] != null) ? Trabajo.fromMap(snapshot['trabajo']) : null,
        negocio = (snapshot['negocio'] != null) ? Negocio.fromMap(snapshot['negocio']) : null,
        referencias = referenciasToMap(snapshot['referencias']) ?? List()
        ;

List referenciasToJson() {

    List jsonList = List();
    if(referencias != null)
      referencias.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Referencia> referenciasToMap(List<dynamic> referencias){
    if(referencias != null)
      return referencias.map((data) => Referencia.fromMap(data)).toList();
    else
      return List<Referencia>();
  }

  // static List<Cliente> ClienteSuperpaleToMap(List<dynamic> Clientes){
  //   if(Clientes != null)
  //     return Clientes.map((data) => Cliente.fromMap(data)).toList();
  //   else
  //     return List<Cliente>();
  // }

  toJson() {
    return {
      "id": id,
      "foto": (foto != null) ? base64Encode(foto) : null,
      "nombres": nombres,
      "apellidos": apellidos,
      "status": status,
      "apodo": apodo,
      "numeroDependientes": numeroDependientes,
      "fechaNacimiento": fechaNacimiento.toString(),
      "sexo": sexo,
      "estadoCivil": estadoCivil,
      "nacionalidad": nacionalidad,
      "tipoVivienda": tipoVivienda,
      "tiempoEnVivienda": tiempoEnVivienda,
      "referidoPor": referidoPor,
      "idDireccion": idDireccion,
      "direccion": direccion,
      "idContacto": idContacto,
      "contacto": contacto.toJson(),
      "idDocumento": idDocumento,
      "documento": documento.toJson(),
      "trabajo": trabajo.toJson(),
      "negocio": negocio.toJson(),
      "referencias": referenciasToJson(),
    };
  }
}