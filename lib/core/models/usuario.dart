

import 'dart:convert';
import 'dart:typed_data';

import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/empresa.dart';
import 'package:prestamo/core/models/rol.dart';
import 'package:prestamo/core/models/sucursal.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/permiso.dart';


class Usuario {
  BigInt id;
  // String foto;
  Uint8List foto;
  String nombreFoto;
  String nombres;
  String apellidos;
  String sexo;
  String usuario;
  String password;
  int status;
  Contacto contacto;
  int idDocumento;
  Rol rol;
  Empresa empresa;
  Sucursal sucursal;
  List<Caja> cajas;
  List<Permiso> permisos;
  String apiKey;


  Usuario({this.id, this.foto, this.nombres, this.apellidos, this.sexo, this.usuario, this.password, this.status = 1, this.contacto, this.rol, this.empresa, this.sucursal, this.cajas, this.permisos, this.nombreFoto, this.apiKey});

  Usuario.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        // foto = (snapshot['foto'] != null) ? base64Decode(snapshot['foto']) : null,
        nombreFoto = snapshot['foto'] ?? '',
        nombres = snapshot['nombres'] ?? '',
        apellidos = snapshot['apellidos'] ?? '',
        sexo = snapshot['sexo'] ?? '',
        usuario = snapshot['usuario'] ?? '',
        password = snapshot['password'] ?? '',
        status = snapshot['status'] ?? 1,
        contacto = (snapshot['contacto'] != null) ? Contacto.fromMap(snapshot['contacto']) : null,
        rol = (snapshot['rol'] != null) ? Rol.fromMap(snapshot['rol']) : null,
        empresa = (snapshot['empresa'] != null) ? Empresa.fromMap(snapshot['empresa']) : null,
        sucursal = (snapshot['sucursal'] != null) ? Sucursal.fromMap(snapshot['sucursal']) : null,
        cajas = cajasToMap(snapshot['cajas']) ?? [],
        permisos = permisosToMap(snapshot['permisos']) ?? [],
        apiKey = snapshot['apiKey'] ?? ''
        ;

List cajasToJson() {

    List jsonList = [];
    if(cajas != null)
      cajas.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Caja> cajasToMap(List<dynamic> cajas){
    if(cajas != null)
      return cajas.map((data) => Caja.fromMap(data)).toList();
    else
      return [];
  }

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

  // static List<Usuario> Usuario(List<dynamic> Usuario){
  //   if(Usuario != null)
  //     return Usuario.map((data) => Usuario.fromMap(data)).toList();
  //   else
  //     return List<Usuario>();
  // }

  toJson() {
    return {
      "id": (id != null) ? id.toInt() : null,
      "foto": (foto != null) ? base64Encode(foto) : null,
      "nombreFoto": nombreFoto,
      "nombres": nombres,
      "apellidos": apellidos,
      "status": status,
      "sexo": sexo,
      "usuario": usuario,
      "password": password,
      "contacto": (contacto != null) ? contacto.toJson() : null,
      "rol": (rol != null) ? rol.toJson() : null,
      "empresa": (empresa != null) ? empresa.toJson() : null,
      "sucursal": (sucursal != null) ? sucursal.toJson() : null,
      "cajas": cajasToJson(),
      "permisos": permisosToJson(),
      "apiKey": apiKey,
    };
  }
}