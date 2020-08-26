

class Estado {
  int id;
  String nombre;
  int idPais;
  String pais;
  

  Estado({this.id, this.nombre, this.idPais, this.pais});

  Estado.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        nombre = snapshot['nombre'] ?? '',
        idPais = snapshot['idPais'] ?? 0,
        pais = snapshot['pais'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "idPais": idPais,
      "pais": pais,
    };
  }
}