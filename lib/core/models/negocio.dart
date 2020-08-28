

import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/classes/utils.dart';


class Negocio {
  int id;
  String nombre;
  String tipo;
  String tiempoExistencia;
  int idDireccion;
  Direccion direccion;


  Negocio({this.id, this.nombre, this.tipo, this.tiempoExistencia, this.idDireccion, this.direccion});

  Negocio.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? '',
        tipo = snapshot['tipo'] ?? '',
        tiempoExistencia = Utils.toDouble(snapshot['tiempoExistencia'].toString()) ?? 0,
        idDireccion = snapshot['idDireccion'] ?? 0,
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

  // static List<Negocio> NegocioSuperpaleToMap(List<dynamic> Negocios){
  //   if(Negocios != null)
  //     return Negocios.map((data) => Negocio.fromMap(data)).toList();
  //   else
  //     return List<Negocio>();
  // }

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "tipo": tipo,
      "tiempoExistencia": tiempoExistencia,
      "direccion": direccion.toJson(),
    };
  }
}