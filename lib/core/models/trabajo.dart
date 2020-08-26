

import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/classes/utils.dart';


class Trabajo {
  int id;
  String foto;
  String nombre;
  String ocupacion;
  double ingresos;
  double otrosIngresos;
  int idDireccion;
  Direccion direccion;


  Trabajo({this.id, this.foto, this.nombre, this.ocupacion, this.ingresos, this.otrosIngresos, this.idDireccion, this.direccion});

  Trabajo.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        foto = snapshot['foto'] ?? '',
        nombre = snapshot['nombre'] ?? '',
        ocupacion = snapshot['ocupacion'] ?? '',
        ingresos = Utils.toDouble(snapshot['ingresos'].toString()) ?? 0,
        otrosIngresos = Utils.toDouble(snapshot['otrosIngresos'].toString()) ?? 0,
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

  // static List<Trabajo> TrabajoSuperpaleToMap(List<dynamic> Trabajos){
  //   if(Trabajos != null)
  //     return Trabajos.map((data) => Trabajo.fromMap(data)).toList();
  //   else
  //     return List<Trabajo>();
  // }

  toJson() {
    return {
      "id": id,
      "foto": foto,
      "nombre": nombre,
      "ocupacion": ocupacion,
      "ingresos": ingresos,
      "otrosIngresos": otrosIngresos,
    };
  }
}