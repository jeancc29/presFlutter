

class Ciudad {
  int id;
  String nombre;
  int idEstado;
  String estado;
  

  Ciudad({this.id, this.nombre, this.idEstado, this.estado});

  Ciudad.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? '',
        idEstado = snapshot['idEstado'] ?? 0,
        estado = snapshot['estado'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "idEstado": idEstado,
      "estado": estado,
    };
  }
}