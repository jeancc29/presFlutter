

class Documento {
  int id;
  String descripcion;
  int idTipoe;
  String tipo;
  

  Documento({this.id, this.descripcion, this.idTipoe, this.tipo});

  Documento.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        idTipoe = snapshot['idTipoe'] ?? 0,
        tipo = snapshot['tipo'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "idTipoe": idTipoe,
      "tipo": tipo,
    };
  }
}