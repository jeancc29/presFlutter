

import 'package:prestamo/core/models/banco.dart';

class Dia {
  int id;
  String dia;
  int weekday;
  bool seleccionado;
  

  Dia({this.id, this.dia, this.weekday, this.seleccionado = false});

  Dia.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        weekday = snapshot['weekday'] ?? 0,
        seleccionado = snapshot['seleccionado'] ?? false,
        dia = snapshot['dia'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "weekday": weekday,
      "dia": dia,
      "seleccionado": seleccionado,
    };
  }
}