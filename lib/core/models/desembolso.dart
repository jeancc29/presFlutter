

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/cuenta.dart';
import 'package:prestamo/core/models/tipo.dart';

class Desembolso {
  int id;
  Tipo tipo;
  Banco banco;
  Cuenta cuenta;
  String numeroCheque;
  Banco bancoDestino;
  String cuentaDestino;
  double montoBruto;
  double montoNeto;
  

  Desembolso({this.id, this.tipo, this.banco, this.cuenta, this.bancoDestino, this.cuentaDestino, this.montoBruto, this.numeroCheque, this.montoNeto});

  Desembolso.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        tipo = (snapshot['tipo'] != null) ? Tipo.fromMap(snapshot['tipo']) : null,
        banco = (snapshot['banco'] != null) ? Banco.fromMap(snapshot['banco']) : null,
        cuenta = (snapshot['cuenta'] != null) ? Cuenta.fromMap(snapshot['cuenta']) : null,
        bancoDestino = (snapshot['bancoDestino'] != null) ? Banco.fromMap(snapshot['bancoDestino']) : null,
        cuentaDestino = snapshot['cuentaDestino'] ?? '',
        montoBruto = Utils.toDouble(snapshot['montoBruto'].toString()) ?? 0,
        montoNeto = Utils.toDouble(snapshot['montoNeto'].toString()) ?? 0,
        numeroCheque = snapshot['numeroCheque'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "tipo": tipo.toJson(),
      "banco": (banco != null) ? banco.toJson() : null,
      "cuenta": (cuenta != null) ? cuenta.toJson() : null,
      "bancoDestino": (bancoDestino != null) ? bancoDestino.toJson() : null,
      "cuentaDestino": cuentaDestino,
      "numeroCheque": numeroCheque,
      "montoNeto": montoNeto,
      "montoBruto": montoBruto,
    };
  }
}