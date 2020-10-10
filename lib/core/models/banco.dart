

class Banco {
  int id;
  String descripcion;
  bool estado;
  

  Banco({this.id, this.descripcion, estado});

  Banco.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        estado = (snapshot['estado'] == 1) ? true : false
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "estado": (estado) ? 1 : 0,
    };
  }
}