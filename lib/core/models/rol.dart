

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/permiso.dart';

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