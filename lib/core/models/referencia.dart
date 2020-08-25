

class Referencia {
  int id;
  String nombre;
  String parentesco;
  String tipo;
  String telefono;
  

  Referencia({this.id, this.nombre, this.parentesco, this.tipo, this.telefono});

  Referencia.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? '',
        parentesco = snapshot['parentesco'] ?? '',
        tipo = snapshot['tipo'] ?? '',
        telefono = snapshot['telefono'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "parentesco": parentesco,
      "tipo": tipo,
      "telefono": telefono,
    };
  }
}