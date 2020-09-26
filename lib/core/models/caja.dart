

import 'package:prestamo/core/classes/utils.dart';

class Caja {
  int id;
  String descripcion;
  double balanceInicial;
  double balance;
  bool validarDesgloseEfectivo;
  bool validarDesgloseCheques;
  bool validarDesgloseTarjetas;
  bool validarDesgloseTransferencias;
  String status;
  

  Caja({this.id, this.descripcion, this.balanceInicial, this.balance, this.validarDesgloseEfectivo, this.validarDesgloseCheques, this.validarDesgloseTarjetas, this.validarDesgloseTransferencias, status});

  Caja.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        balanceInicial = Utils.toDouble(snapshot['balanceInicial'].toString()) ?? 0,
        balance = Utils.toDouble(snapshot['balance'].toString()) ?? 0,
        validarDesgloseEfectivo = snapshot['validarDesgloseEfectivo'] == 1 ? true : false,
        validarDesgloseCheques = snapshot['validarDesgloseCheques'] == 1 ? true : false,
        validarDesgloseTarjetas = snapshot['validarDesgloseTarjetas'] == 1 ? true : false,
        validarDesgloseTransferencias = snapshot['validarDesgloseTransferencias'] == 1 ? true : false,
        status = snapshot['status'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "balanceInicial": balanceInicial,
      "validarDesgloseEfectivo": validarDesgloseEfectivo,
      "validarDesgloseCheques": validarDesgloseCheques,
      "validarDesgloseTarjetas": validarDesgloseTarjetas,
      "validarDesgloseTransferencias": validarDesgloseTransferencias,
      "balance": balance,
      "status": status,
    };
  }
}