

import 'package:prestamo/core/classes/utils.dart';

class Moneda {
  int id;
  String nombre;
  String simbolo;
  String codigo;
  double equivalenciaDolar;
  

  Moneda({this.id, this.nombre, this.simbolo, this.codigo, this.equivalenciaDolar});

  Moneda.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? '',
        simbolo = snapshot['simbolo'] ?? '',
        codigo = snapshot['codigo'] ?? '',
        equivalenciaDolar = Utils.toDouble(snapshot['equivalenciaDolar'].toString()) ?? 0
        ;


  

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "simbolo": simbolo,
      "codigo": codigo,
      "equivalenciaDolar": equivalenciaDolar,
    };
  }
}