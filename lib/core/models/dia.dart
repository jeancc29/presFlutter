

import 'package:prestamo/core/models/banco.dart';

class Dia {
  int id;
  String dia;
  bool seleccionado;
  

  Dia({this.id, this.dia, this.seleccionado = false});

  Dia.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        seleccionado = snapshot['seleccionado'] ?? false,
        dia = snapshot['dia'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "dia": dia,
      "seleccionado": seleccionado,
    };
  }
}