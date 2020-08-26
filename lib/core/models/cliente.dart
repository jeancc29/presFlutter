

import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/referencia.dart';

class Cliente {
  int id;
  String foto;
  String nombres;
  String apellidos;
  String apodo;
  int numeroDependientes;
  DateTime fechaNacimiento;
  String sexo;
  String estadoCivil;
  int status;
  int idDireccion;
  Direccion direccion;
  int idContacto;
  Contacto contacto;
  int idDocumento;
  Documento documento;
  List<Referencia> referencias;

  String nacionalidad;

  Cliente({this.id, this.foto, this.nombres, this.apellidos, this.apodo, this.numeroDependientes, this.fechaNacimiento, this.sexo, this.estadoCivil, this.status, this.nacionalidad, this.idDireccion, this.direccion, this.idContacto, this.contacto, this.idDocumento, this.documento, this.referencias});

  Cliente.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        foto = snapshot['foto'] ?? '',
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
        referencias = referenciasToMap(snapshot['referencias']) ?? List()
        ;

// List sorteosToJson() {

//     List jsonList = List();
//     sorteos.map((u)=>
//       jsonList.add(u.toJson())
//     ).toList();
//     return jsonList;
//   }

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
      "foto": foto,
      "nombres": nombres,
      "apellidos": apellidos,
      "status": status,
      "apodo": apodo,
      "numeroDependientes": numeroDependientes,
      "fechaNacimiento": fechaNacimiento.toString(),
      "sexo": sexo,
      "estadoCivil": estadoCivil,
      "nacionalidad": nacionalidad,
      "idDireccion": idDireccion,
      "direccion": direccion,
      "idContacto": idContacto,
      "contacto": contacto,
      "idDocumento": idDocumento,
      "documento": documento,
      "referencias": referencias,
    };
  }
}