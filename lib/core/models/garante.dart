

class Garante {
  int id;
  String nombres;
  String numeroIdentificacion;
  String telefono;
  String direccion;
  

  Garante({this.id, this.nombres, this.numeroIdentificacion, this.telefono, this.direccion});

  Garante.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombres = snapshot['nombres'] ?? '',
        numeroIdentificacion = snapshot['numeroIdentificacion'] ?? '',
        telefono = snapshot['telefono'] ?? '',
        direccion = snapshot['direccion'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "nombres": nombres,
      "numeroIdentificacion": numeroIdentificacion,
      "telefono": telefono,
      "direccion": direccion,
    };
  }
}