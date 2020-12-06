

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/tipo.dart';

class Loanexpense {
  int id;
  double porcentaje;
  double importe;
  Tipo tipo;
  

  Loanexpense({this.id, this.porcentaje, this.importe, this.tipo});

  Loanexpense.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        porcentaje = Utils.toDouble(snapshot['porcentaje'].toString()) ?? 0,
        importe = Utils.toDouble(snapshot['importe'].toString()) ?? 0,
        tipo = (snapshot['tipo'] != null) ? Tipo.fromMap(snapshot['tipo']) : null
        ;


  

  toJson() {
    return {
      "id": id,
      "porcentaje": porcentaje,
      "importe": importe,
      "tipo": tipo.toJson(),
    };
  }
}