

class Ruta {
  int id;
  String descripcion;
  String renglon;
  

  Ruta({this.id, this.descripcion, this.renglon});

  Ruta.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? ''
        ;


  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
    };
  }
}