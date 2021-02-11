

import 'package:prestamo/core/classes/utils.dart';

class Detallepago {
  BigInt id;
  BigInt idPago;
  BigInt idAmortizacion;
  double capital;
  double interes;
  double mora;
  double descuento;
  

  Detallepago({this.id, this.idPago, this.idAmortizacion, this.capital, this.interes, this.mora, this.descuento});

  Detallepago.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        idPago = (snapshot['idPago'] != null) ? BigInt.from(snapshot['idPago']) : BigInt.from(0),
        idAmortizacion = (snapshot['idAmortizacion'] != null) ? BigInt.from(snapshot['idAmortizacion']) : BigInt.from(0),
        capital = Utils.toDouble(snapshot['capital'].toString()) ?? 0,
        interes = Utils.toDouble(snapshot['interes'].toString()) ?? 0,
        mora = Utils.toDouble(snapshot['mora'].toString()) ?? 0,
        descuento = Utils.toDouble(snapshot['descuento'].toString()) ?? 0
        ;


  

  toJson() {
    return {
      "id": id,
      "idPago": idPago,
      "idAmortizacion": idAmortizacion,
      "capital": capital,
      "interes": interes,
      "mora": mora,
      "descuento": descuento,
    };
  }
}