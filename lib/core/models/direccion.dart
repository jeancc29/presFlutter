

class Direccion {
  int id;
  String direccion;
  int idCiudad;
  String ciudad;
  int idProvincia;
  String provincia;
  String sector;
  String numero;
  

  Direccion({this.id, this.direccion, this.ciudad, this.provincia, this.sector, this.numero});

  Direccion.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        direccion = snapshot['direccion'] ?? '',
        ciudad = snapshot['ciudad'] ?? '',
        provincia = snapshot['provincia'] ?? '',
        sector = snapshot['sector'] ?? '',
        numero = snapshot['numero'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "direccion": direccion,
      "ciudad": ciudad,
      "provincia": provincia,
      "sector": sector,
      "numero": numero,
    };
  }
}