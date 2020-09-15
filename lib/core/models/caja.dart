

import 'package:prestamo/core/classes/utils.dart';

class Caja {
  int id;
  String descripcion;
  double balanceInicial;
  double balance;
  String status;
  

  Caja({this.id, this.descripcion, this.balanceInicial, this.balance, this.status});

  Caja.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        balanceInicial = Utils.toDouble(snapshot['balanceInicial'].toString()) ?? 0,
        balance = Utils.toDouble(snapshot['balance'].toString()) ?? 0,
        status = snapshot['status'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "balanceInicial": balanceInicial,
      "balance": balance,
      "status": status,
    };
  }
}