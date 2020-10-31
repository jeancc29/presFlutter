

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/contacto.dart';
import 'package:prestamo/core/models/direccion.dart';
import 'package:prestamo/core/models/documento.dart';
import 'package:prestamo/core/models/negocio.dart';
import 'package:prestamo/core/models/referencia.dart';
import 'package:prestamo/core/models/tipo.dart';
import 'package:prestamo/core/models/trabajo.dart';

class Garantia {
  BigInt id;
  // String foto;
  Uint8List foto;
  String descripcion;
  String matricula;
  String marca;
  String modelo;
  String color;
  double tasacion;
  int numeroPuertas;
  Tipo condicion;
  Tipo tipo;
  Tipo tipoGarantia;
  DateTime anoFabricacion;
  DateTime fechaExpedicion;
  String chasis;
  int cilindros;
  int numeroPasajeros;
  String motorOSerie;
  int fuerzaMotriz;
  int capacidadCarga;
  String placa;
  String placaAnterior;
  int status;


  Garantia({this.id, this.foto, this.descripcion, this.marca, this.modelo, this.color, this.tasacion, this.numeroPuertas, this.condicion, this.tipo, this.tipoGarantia, this.anoFabricacion, this.fechaExpedicion, this.chasis, this.cilindros, this.numeroPasajeros, this.motorOSerie, this.fuerzaMotriz, this.capacidadCarga, this.placa, this.placaAnterior, this.status, this.matricula});

  Garantia.fromMap(Map snapshot) :
        id = (snapshot['id'] != null) ? BigInt.from(snapshot['id']) : BigInt.from(0),
        foto = (snapshot['foto'] != null) ? base64Decode(snapshot['foto']) : null,
        descripcion = snapshot['descripcion'] ?? '',
        matricula = snapshot['matricula'] ?? '',
        marca = snapshot['marca'] ?? '',
        modelo = snapshot['modelo'] ?? '',
        color = snapshot['color'] ?? '',
        tasacion = snapshot['tasacion'] != null ? Utils.toDouble(snapshot['tasacion']) : 0,
        numeroPuertas = snapshot['numeroPuertas'] ?? 0,
        condicion = (snapshot['condicion'] != null) ? Tipo.fromMap(snapshot['condicion']) : null,
        tipo = (snapshot['tipo'] != null) ? Tipo.fromMap(snapshot['tipo']) : null,
        tipoGarantia = (snapshot['tipoGarantia'] != null) ? Tipo.fromMap(snapshot['tipoGarantia']) : null,
        anoFabricacion = (snapshot['anoFabricacion'] != null) ? DateTime.parse(snapshot['anoFabricacion']) : null,
        fechaExpedicion = (snapshot['fechaExpedicion'] != null) ? DateTime.parse(snapshot['fechaExpedicion']) : null,
        chasis = snapshot['chasis'] ?? '',
        cilindros = snapshot['cilindros'] ?? 0,
        numeroPasajeros = snapshot['numeroPasajeros'] ?? 0,
        motorOSerie = snapshot['motorOSerie'] ?? '',
        fuerzaMotriz = snapshot['fuerzaMotriz'] ?? 0,
        capacidadCarga = snapshot['capacidadCarga'] ?? 0,
        placa = snapshot['placa'] ?? '', 
        placaAnterior = snapshot['placaAnterior'] ?? '', 
        status = snapshot['status'] ?? 1
        ;

// List referenciasToJson() {

//     List jsonList = List();
//     if(referencias != null)
//       referencias.map((u)=>
//         jsonList.add(u.toJson())
//       ).toList();
//     return jsonList;
//   }

  static List<Referencia> referenciasToMap(List<dynamic> referencias){
    if(referencias != null)
      return referencias.map((data) => Referencia.fromMap(data)).toList();
    else
      return List<Referencia>();
  }

  // static List<Garantia> GarantiaSuperpaleToMap(List<dynamic> Garantias){
  //   if(Garantias != null)
  //     return Garantias.map((data) => Garantia.fromMap(data)).toList();
  //   else
  //     return List<Garantia>();
  // }

  toJson() {
    return {
      "id": id,
      "foto": (foto != null) ? base64Encode(foto) : null,
      "descripcion": descripcion,
      "matricula": matricula,
      "marca": marca,
      "modelo": modelo,
      "status": status,
      "color": color,
      "tasacion": tasacion,
      "numeroPuertas": numeroPuertas,
      "condicion": condicion,
      "tipo": tipo,
      "tipoGarantia": tipoGarantia,
      "anoFabricacion": anoFabricacion.toString(),
      "fechaExpedicion": fechaExpedicion.toString(),
      "chasis": chasis,
      "cilindros": cilindros,
      "numeroPasajeros": numeroPasajeros,
      "motorOSerie": motorOSerie,
      "capacidadCarga": capacidadCarga,
      "placa": placa,
      "placaAnterior": placaAnterior,
    };
  }
}