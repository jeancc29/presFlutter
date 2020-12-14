

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/amortizacion.dart';
import 'package:prestamo/core/models/caja.dart';
import 'package:prestamo/core/models/cobrador.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/desembolso.dart';
import 'package:prestamo/core/models/dia.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/cliente.dart';
import 'package:prestamo/core/models/garante.dart';
import 'package:prestamo/core/models/garantia.dart';
import 'package:prestamo/core/models/gastoprestamo.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';

class Prestamo {
  BigInt id;
  Cliente cliente;
  Tipo tipoPlazo;
  Tipo tipoAmortizacion;
  double monto;
  double porcentajeInteres;
  double porcentajeInteresAnual;
  int numeroCuotas;
  DateTime fecha;
  DateTime fechaPrimerPago;
  Caja caja;
  String codigo;
  List<Dia> diasExcluidos;
  double porcentajeMora;
  int diasGracia;
  Cobrador cobrador;
  Garante garante;
  Gastoprestamo gastoPrestamo;
  List<Garantia> garantias;
  Desembolso desembolso;
  int idcliente;
  String nacionalidad;
  List<Amortizacion> amortizaciones;

  double cuota;
  double balancePendiente;
  double capitalPendiente;
  DateTime fechaProximoPago;
  double montoPagado;

  Prestamo({this.id, this.cliente, this.tipoPlazo, this.tipoAmortizacion, this.monto, this.porcentajeInteres, this.porcentajeInteresAnual, this.numeroCuotas, this.fecha, this.fechaPrimerPago, this.caja, this.codigo, this.diasExcluidos, this.porcentajeMora, this.diasGracia, this.cobrador, this.garante, this.nacionalidad, this.garantias, this.desembolso, this.gastoPrestamo, this.idcliente});

  Prestamo.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        tipoPlazo = (snapshot['tipoPlazo'] != null) ? Tipo.fromMap(Utils.parsedToJsonOrNot(snapshot['tipoPlazo'])) : null,
        tipoAmortizacion = (snapshot['tipoAmortizacion'] != null) ? Tipo.fromMap(Utils.parsedToJsonOrNot(snapshot['tipoAmortizacion'])) : null,
        monto = Utils.toDouble(snapshot['monto'].toString()) ?? 0,
        porcentajeInteres = Utils.toDouble(snapshot['porcentajeInteres'].toString()) ?? 0,
        porcentajeInteresAnual = Utils.toDouble(snapshot['porcentajeInteresAnual'].toString()) ?? 0,
        numeroCuotas = Utils.toInt(snapshot['numeroCuotas'].toString()) ?? 0,
        fecha = (snapshot['fecha'] != null) ? DateTime.parse(snapshot['fecha']) : null,
        fechaPrimerPago = (snapshot['fechaPrimerPago'] != null) ? DateTime.parse(snapshot['fechaPrimerPago']) : null,
        caja = (snapshot['caja'] != null) ? Caja.fromMap(Utils.parsedToJsonOrNot(snapshot['caja'])) : null,
        codigo = snapshot['codigo'] ?? '',
        diasExcluidos = diasExcluidosToMap(snapshot['diasExcluidos']) ?? List(),
        porcentajeMora = Utils.toDouble(snapshot['porcentajeMora'].toString()) ?? 0,
        diasGracia = Utils.toInt(snapshot['diasGracia'].toString()) ?? 0,
        cobrador = (snapshot['cobrador'] != null) ? Cobrador.fromMap(Utils.parsedToJsonOrNot(snapshot['cobrador'])) : null,
        garante = (snapshot['garante'] != null) ? Garante.fromMap(Utils.parsedToJsonOrNot(snapshot['garante'])) : null,
        nacionalidad= snapshot['nacionalidad'] ?? '',
        gastoPrestamo = (snapshot['gastoPrestamo'] != null) ? Gastoprestamo.fromMap(Utils.parsedToJsonOrNot(snapshot['gastoPrestamo'])) : null,
        garantias = garantiasToMap(snapshot['garantias']) ?? List(),
        desembolso = (snapshot['desembolso'] != null) ? Desembolso.fromMap(Utils.parsedToJsonOrNot(snapshot['desembolso'])) : null,
        idcliente = snapshot['idcliente'] ?? 0,
        cliente = (snapshot['cliente'] != null) ? Cliente.fromMap(Utils.parsedToJsonOrNot(snapshot['cliente'])) : null,
        amortizaciones = amortizacionesToMap(snapshot['amortizaciones']) ?? List(),

        cuota = Utils.toDouble(snapshot['cuota'].toString()) ?? 0,
        balancePendiente = Utils.toDouble(snapshot['balancePendiente'].toString()) ?? 0,
        capitalPendiente = Utils.toDouble(snapshot['capitalPendiente'].toString()) ?? 0,
        fechaProximoPago = (snapshot['fechaProximoPago'] != null) ? DateTime.parse(snapshot['fechaProximoPago']) : null,
        montoPagado = Utils.toDouble(snapshot['montoPagado'].toString()) ?? 0
        ;

List diasExcluidosToJson() {

    List jsonList = List();
    if(diasExcluidos != null)
      diasExcluidos.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Dia> diasExcluidosToMap(List<dynamic> diasExcluidos){
    if(diasExcluidos != null)
      return diasExcluidos.map((data) => Dia.fromMap(data)).toList();
    else
      return List<Dia>();
  }

  List garantiasToJson() {

    List jsonList = List();
    if(garantias != null)
      garantias.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Garantia> garantiasToMap(List<dynamic> garantias){
    if(garantias != null)
      return garantias.map((data) => Garantia.fromMap(data)).toList();
    else
      return List<Garantia>();
  }

  List amortizacionesToJson() {

    List jsonList = List();
    if(amortizaciones != null)
      amortizaciones.map((u)=>
        jsonList.add(u.toJson())
      ).toList();
    return jsonList;
  }

  static List<Amortizacion> amortizacionesToMap(List<dynamic> amortizaciones){
    if(amortizaciones != null)
      return amortizaciones.map((data) => Amortizacion.fromMap(data)).toList();
    else
      return List<Amortizacion>();
  }

  // static List<Prestamo> PrestamoSuperpaleToMap(List<dynamic> Prestamos){
  //   if(Prestamos != null)
  //     return Prestamos.map((data) => Prestamo.fromMap(Utils.parsedToJsonOrNot(data)).toList();)
  //   else
  //     return List<Prestamo>();
  // }

  toJson() {
    return {
      "id": (id != null) ? id.toInt() : null,
      "cliente": cliente.toJson(),
      "tipoPlazo": (tipoPlazo != null) ? tipoPlazo.toJson() : null,
      "tipoAmortizacion": (tipoAmortizacion != null) ? tipoAmortizacion.toJson() : null,
      "porcentajeInteres": porcentajeInteres,
      "porcentajeInteresAnual": porcentajeInteresAnual,
      "numeroCuotas": numeroCuotas,
      "fecha": fecha.toString(),
      "fechaPrimerPago": fechaPrimerPago.toString(),
      "caja": (caja != null) ? caja.toJson() : null,
      "codigo": codigo,
      "diasExcluidos": diasExcluidosToJson(),
      "porcentajeMora": porcentajeMora,
      "diasGracia": diasGracia,
      "cobrador": (cobrador != null) ? cobrador.toJson() : null,
      "garante": (garante != null) ? garante.toJson() : null,
      "nacionalidad": nacionalidad,
      "monto": monto,
      "gastoPrestamo": (gastoPrestamo != null) ? gastoPrestamo.toJson() : null,
      "garantias": garantiasToJson(),
      "desembolso": (desembolso != null) ? desembolso.toJson() : null,
      "idcliente": idcliente,
      "amortizaciones": amortizacionesToJson(),
    };
  }
}