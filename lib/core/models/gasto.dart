

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/tipo.dart';

class Gasto {
  int id;
  String concepto;
  String comentario;
  DateTime fecha;
  int idCaja;
  Caja caja;
  int idTipo;
  Tipo tipo;
  int idUsuario;
  double monto;
  

  Gasto({this.id, this.concepto, this.comentario, this.fecha, this.idCaja, this.caja, this.idTipo, this.tipo, this.idUsuario, this.monto});

  Gasto.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        fecha = (snapshot['fecha'] != null) ? DateTime.parse(snapshot['fecha']) : null,
        concepto = snapshot['concepto'] ?? '',
        comentario = snapshot['comentario'] ?? '',
        idCaja = snapshot['idCaja'] ?? 0,
        caja = (snapshot['caja'] != null) ? Caja.fromMap(snapshot['caja']) : null,
        idTipo = snapshot['idTipo'] ?? 0,
        tipo = (snapshot['tipo'] != null) ? Tipo.fromMap(snapshot['tipo']) : null,
        idUsuario = snapshot['idUsuario'] ?? 0,
        monto = Utils.toDouble(snapshot['monto'].toString()) ?? 0
        ;


  

  toJson() {
    return {
      "id": id,
      "fecha": fecha.toString(),
      "concepto": concepto,
      "idCaja": idCaja,
      "idTipo": idTipo,
      "idUsuario": idUsuario,
      "monto": monto,
      "comentario": comentario,
    };
  }
}