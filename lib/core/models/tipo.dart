

class Tipo {
  int id;
  String descripcion;
  String renglon;
  

  Tipo({this.id, this.descripcion, this.renglon});

  Tipo.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        renglon = snapshot['renglon'] ?? ''
        ;


  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "renglon": renglon,
    };
  }
}