

class ConfiguracionPrestamo {
  int id;
  bool garantia;
  bool gasto;
  bool desembolso;
  String estado;
  

  ConfiguracionPrestamo({this.id, this.garantia, this.gasto, this.desembolso, this.estado});

  ConfiguracionPrestamo.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        garantia = snapshot['garantia'] == 1 ? true : false,
        gasto = snapshot['gasto'] == 1 ? true : false,
        desembolso = snapshot['desembolso'] == 1 ? true : false
        ;


  

  toJson() {
    return {
      "id": id,
      "garantia": garantia,
      "gasto": gasto,
      "desembolso": desembolso,
      "estado": estado,
    };
  }
}