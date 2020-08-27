

class Documento {
  int id;
  String descripcion;
  int idTipo;
  String tipo;
  

  Documento({this.id, this.descripcion, this.idTipo, this.tipo});

  Documento.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        idTipo = snapshot['idTipo'] ?? 0,
        tipo = snapshot['tipo'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "idTipo": idTipo,
      "tipo": tipo,
    };
  }
}