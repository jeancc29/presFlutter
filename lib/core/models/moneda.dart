

class Moneda {
  int id;
  String descripcion;
  int equivalenciaDolar;
  

  Moneda({this.id, this.descripcion, this.equivalenciaDolar});

  Moneda.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        equivalenciaDolar = snapshot['equivalenciaDolar'] ?? 0
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "equivalenciaDolar": equivalenciaDolar,
    };
  }
}