

// import 'dart:convert';
// import 'dart:html';
// import 'dart:typed_data';

// import 'package:prestamo/core/classes/utils.dart';
// import 'package:prestamo/core/models/caja.dart';
// import 'package:prestamo/core/models/cobrador.dart';
// import 'package:prestamo/core/models/contacto.dart';
// import 'package:prestamo/core/models/dia.dart';
// import 'package:prestamo/core/models/direccion.dart';
// import 'package:prestamo/core/models/cliente.dart';
// import 'package:prestamo/core/models/garante.dart';
// import 'package:prestamo/core/models/negocio.dart';
// import 'package:prestamo/core/models/referencia.dart';
// import 'package:prestamo/core/models/tipo.dart';

// class Prestamo {
//   BigInt id;
//   Cliente cliente;
//   Tipo tipoPlazo;
//   Tipo tipoAmortizacion;
//   double monto;
//   double porcentajeInteres;
//   double porcentajeInteresAnual;
//   int numeroCuotas;
//   DateTime fecha;
//   DateTime fechaPrimerPago;
//   Caja caja;
//   String codigo;
//   List<Dia> diasExcluidos;
//   double porcentajeMora;
//   int diasGracia;
//   Cobrador cobrador;
//   Garante garante;
//   Gasto gasto;
//   Contacto contacto;
//   int idcliente;
//   Negocio negocio;

//   String nacionalidad;

//   Prestamo({this.id, this.cliente, this.tipoPlazo, this.tipoAmortizacion, this.monto, this.porcentajeInteres, this.porcentajeInteresAnual, this.numeroCuotas, this.fecha, this.fechaPrimerPago, this.caja, this.codigo, this.diasExcluidos, this.porcentajeMora, this.diasGracia, this.cobrador, this.garante, this.nacionalidad, this.garante, this.gasto, this.contacto, this.idcliente, this.cliente, this.negocio});

//   Prestamo.fromMap(Map snapshot) :
//         id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
//         tipoPlazo = (snapshot['tipoPlazo'] != null) ? Tipo.fromMap(snapshot['tipoPlazo']) : null,
//         tipoAmortizacion = (snapshot['tipoAmortizacion'] != null) ? Tipo.fromMap(snapshot['tipoAmortizacion']) : null,
//         monto = Utils.toDouble(snapshot['monto'].toString()) ?? 0,
//         porcentajeInteres = Utils.toDouble(snapshot['porcentajeInteres'].toString()) ?? 0,
//         porcentajeInteresAnual = Utils.toDouble(snapshot['porcentajeInteresAnual'].toString()) ?? 0,
//         numeroCuotas = Utils.toInt(snapshot['numeroCuotas'].toString()) ?? 0,
//         fecha = (snapshot['fecha'] != null) ? DateTime.parse(snapshot['fecha']) : null,
//         fechaPrimerPago = (snapshot['fechaPrimerPago'] != null) ? DateTime.parse(snapshot['fechaPrimerPago']) : null,
//         caja = (snapshot['caja'] != null) ? Caja.fromMap(snapshot['caja']) : null,
//         codigo = snapshot['codigo'] ?? '',
//         diasExcluidos = diasExcluidosToMap(snapshot['diasExcluidos']) ?? List(),
//         porcentajeMora = Utils.toDouble(snapshot['porcentajeMora'].toString()) ?? 0,
//         diasGracia = Utils.toInt(snapshot['diasGracia'].toString()) ?? 0,
//         cobrador = (snapshot['cobrador'] != null) ? Cobrador.fromMap(snapshot['cobrador']) : null,
//         garante = (snapshot['garante'] != null) ? Garante.fromMap(snapshot['garante']) : null,
//         nacionalidad= snapshot['nacionalidad'] ?? '',
//         gasto = snapshot['gasto'] ?? 0,
//         contacto = (snapshot['contacto'] != null) ? Contacto.fromMap(snapshot['contacto']) : null,
//         idcliente = snapshot['idcliente'] ?? 0,
//         cliente = (snapshot['cliente'] != null) ? Cliente.fromMap(snapshot['cliente']) : null,
//         negocio = (snapshot['negocio'] != null) ? Negocio.fromMap(snapshot['negocio']) : null
//         ;

// List diasExcluidosToJson() {

//     List jsonList = List();
//     if(diasExcluidos != null)
//       diasExcluidos.map((u)=>
//         jsonList.add(u.toJson())
//       ).toList();
//     return jsonList;
//   }

//   static List<Referencia> diasExcluidosToMap(List<dynamic> diasExcluidos){
//     if(diasExcluidos != null)
//       return diasExcluidos.map((data) => Referencia.fromMap(data)).toList();
//     else
//       return List<Referencia>();
//   }

//   // static List<Prestamo> PrestamoSuperpaleToMap(List<dynamic> Prestamos){
//   //   if(Prestamos != null)
//   //     return Prestamos.map((data) => Prestamo.fromMap(data)).toList();
//   //   else
//   //     return List<Prestamo>();
//   // }

//   toJson() {
//     return {
//       "id": id,
//       "cliente": cliente.toJson(),
//       "tipoPlazo": tipoPlazo.toJson(),
//       "tipoAmortizacion": tipoAmortizacion,
//       "porcentajeInteres": porcentajeInteres,
//       "porcentajeInteresAnual": porcentajeInteresAnual,
//       "numeroCuotas": numeroCuotas,
//       "fecha": fecha.toString(),
//       "fechaPrimerPago": fechaPrimerPago.toString(),
//       "caja": caja.toJson(),
//       "codigo": codigo,
//       "diasExcluidos": diasExcluidosToJson(),
//       "porcentajeMora": porcentajeMora,
//       "diasGracia": diasGracia,
//       "cobrador": cobrador.toJson(),
//       "garante": garante.toJson(),
//       "nacionalidad": nacionalidad,
//       "monto": monto,
//       "gasto": gasto,
//       "contacto": contacto.toJson(),
//       "idcliente": idcliente,
//       "negocio": negocio.toJson(),
//     };
//   }
// }