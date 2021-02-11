

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/detallepago.dart';
import 'package:prestamo/core/models/usuario.dart';

class Pago {
  BigInt id;
  BigInt idUsuario;
  int idCaja;
  int idEmpresa;
  int idTipoPago;
  double monto;
  double devuelta;
  String comentario;
  List<Detallepago> detallepago;
  Usuario usuario;
  Caja caja;


  Pago({this.id, this.idUsuario, this.idCaja, this.idEmpresa, this.idTipoPago, this.monto, this.devuelta, this.comentario, this.detallepago, this.usuario, this.caja});

  Pago.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        idUsuario = (snapshot['idUsuario'] != null) ? BigInt.from(snapshot['idUsuario']) : BigInt.from(0),
        idCaja = Utils.toInt(snapshot['idCaja'].toString()) ?? 0,
        idEmpresa = Utils.toInt(snapshot['idEmpresa'].toString()) ?? 0,
        idTipoPago = Utils.toInt(snapshot['idTipoPago'].toString()) ?? 0,
        monto = Utils.toDouble(snapshot['monto'].toString()) ?? 0,
        devuelta = Utils.toDouble(snapshot['devuelta'].toString()) ?? 0,
        comentario = snapshot['comentario'] ?? '',
        detallepago = detallepagoToMap(snapshot['detallepago']) ?? [],
        usuario = (snapshot['usuario'] != null) ? Usuario.fromMap(snapshot['usuario']) : null,
        caja = (snapshot['caja'] != null) ? Caja.fromMap(snapshot['caja']) : null
        ;


  List detallepagoToJson() {

    List jsonList = [];
    if(detallepago != null)
      detallepago.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Detallepago> detallepagoToMap(List<dynamic> detallepago){
    if(detallepago != null)
      return detallepago.map((data) => Detallepago.fromMap(data)).toList();
    else
      return [];
  }

  toJson() {
    return {
      "id": id.toInt(),
      "idUsuario": idUsuario.toInt(),
      "idCaja": idCaja,
      "idEmpresa": idEmpresa,
      "idTipoPago": idTipoPago,
      "monto": monto,
      "comentario": comentario,
      "usuario": (usuario != null) ? usuario.toJson() : null,
      "caja": (caja != null) ? caja.toJson() : null,
      "detallepago": detallepagoToJson(),
    };
  }
}