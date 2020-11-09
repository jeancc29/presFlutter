

import 'package:prestamo/core/models/banco.dart';

class Cuenta {
  int id;
  String descripcion;
  int idBanco;
  Banco banco;
  

  Cuenta({this.id, this.descripcion, this.idBanco, this.banco});

  Cuenta.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        idBanco = snapshot['idBanco'] ?? 0,
        banco = (snapshot['banco'] != null) ? Banco.fromMap(snapshot['banco']) : null
       
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "idBanco": idBanco,
      "banco": banco,
    };
  }
}