

import 'package:prestamo/core/models/ciudad.dart';
import 'package:prestamo/core/models/estado.dart';

class Direccion {
  int id;
  String direccion;
  int idCiudad;
  Ciudad ciudad;
  int idEstado;
  Estado estado;
  String sector;
  String numero;
  

  Direccion({this.id, this.direccion, this.idCiudad, this.ciudad, this.idEstado, this.estado, this.sector, this.numero});

  Direccion.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        direccion = snapshot['direccion'] ?? '',
        idCiudad = snapshot['idCiudad'] ?? 0,
        ciudad = (snapshot['ciudad'] != null) ? Ciudad.fromMap(snapshot['ciudad']) : null,
        idEstado = snapshot['idEstado'] ?? 0,
        estado = (snapshot['estado'] != null) ? Estado.fromMap(snapshot['estado']) : null,
        sector = snapshot['sector'] ?? '',
        numero = snapshot['numero'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "direccion": direccion,
      "ciudad": ciudad.toJson(),
      "idCiudad": idCiudad,
      "estado": estado.toJson(),
      "idEstado": idEstado,
      "sector": sector,
      "numero": numero,
    };
  }
}