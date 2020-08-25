

import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/referencia.dart';

class Cliente {
  int id;
  String nombres;
  String apellidos;
  String apodo;
  int numeroDependientes;
  DateTime fechaNacimiento;
  String sexo;
  String estadoCivil;
  int status;
  Direccion direccion;
  List<Referencia> referencias;

  String nacionalidad;

  Cliente({this.id, this.nombres, this.apellidos, this.apodo, this.numeroDependientes, this.fechaNacimiento, this.sexo, this.estadoCivil, this.status, this.nacionalidad, this.direccion});

  Cliente.fromMap(Map snapshot, id) :
        id = id ?? 0,
        nombres = snapshot['nombres'] ?? '',
        apellidos = snapshot['apellidos'] ?? '',
        apodo = snapshot['apodo'] ?? '',
        numeroDependientes = snapshot['numeroDependientes'] ?? 0,
        fechaNacimiento = (snapshot['fechaNacimiento'] != null) ? DateTime.parse(snapshot['fechaNacimiento']) : null,
        sexo = snapshot['sexo'] ?? '',
        estadoCivil = snapshot['estadoCivil'] ?? '',
        status = snapshot['status'] ?? 1,
        nacionalidad= snapshot['nacionalidad'] ?? '',
        direccion = (snapshot['direccion'] != null) ? Direccion.fromMap(snapshot['direccion']) : null
        ;

// List sorteosToJson() {

//     List jsonList = List();
//     sorteos.map((u)=>
//       jsonList.add(u.toJson())
//     ).toList();
//     return jsonList;
//   }

  // static List<Draws> sorteosToMap(List<dynamic> sorteos){
  //   if(sorteos != null)
  //     return sorteos.map((data) => Draws.fromMap(data)).toList();
  //   else
  //     return List<Draws>();
  // }

  // static List<Cliente> ClienteSuperpaleToMap(List<dynamic> Clientes){
  //   if(Clientes != null)
  //     return Clientes.map((data) => Cliente.fromMap(data)).toList();
  //   else
  //     return List<Cliente>();
  // }

  toJson() {
    return {
      "id": id,
      "nombres": nombres,
      "apellidos": apellidos,
      "status": status,
      "apodo": apodo,
      "numeroDependientes": numeroDependientes,
      "fechaNacimiento": fechaNacimiento.toString(),
      "sexo": sexo,
      "estadoCivil": estadoCivil,
      "nacionalidad": nacionalidad,
    };
  }
}