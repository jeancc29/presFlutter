

class Cobrador {
  int id;
  String nombre;
  

  Cobrador({this.id, this.nombre});

  Cobrador.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
    };
  }
}