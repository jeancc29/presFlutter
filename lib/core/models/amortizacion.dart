

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/banco.dart';
import 'package:prestamo/core/models/tipo.dart';

class Amortizacion {
  int id;
  double cuota;
  double interes;
  double capital;
  double capitalRestante;
  double capitalSaldado;
  double interesSaldado;
  int idTipo;
  Tipo tipo;
  int idPrestamo;
  

  Amortizacion({this.id, this.cuota, this.interes, this.capital, this.capitalRestante, this.capitalSaldado, this.interesSaldado, this.idTipo, this.tipo, this.idPrestamo});

  Amortizacion.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        cuota = (snapshot['cuota'] != null) ? Utils.toDouble(snapshot['cuota'].toString()) : 0,
        interes = (snapshot['interes'] != null) ? Utils.toDouble(snapshot['interes'].toString()) : 0,
        capital = (snapshot['capital'] != null) ? Utils.toDouble(snapshot['capital'].toString()) : 0,
        capitalRestante = (snapshot['capitalRestante'] != null) ? Utils.toDouble(snapshot['capitalRestante'].toString()) : 0,
        capitalSaldado = (snapshot['capitalSaldado'] != null) ? Utils.toDouble(snapshot['capitalSaldado'].toString()) : 0,
        interesSaldado = (snapshot['interesSaldado'] != null) ? Utils.toDouble(snapshot['interesSaldado'].toString()) : 0,
        idTipo = snapshot['idTipo'] ?? 0,
        idPrestamo = snapshot['idPrestamo'] ?? 0,
        tipo = (snapshot['tipo'] != null) ? Tipo.fromMap(snapshot['tipo']) : null
        ;


  

  toJson() {
    return {
      "id": id,
      "cuota": cuota,
      "interes": interes,
      "capital": capital,
      "capitalRestante": capitalRestante,
      "capitalSaldado": capitalSaldado,
      "interesSaldado": interesSaldado,
      "idTipo": idTipo,
      "tipo": tipo,
      "idPrestamo": idPrestamo,
    };
  }
}