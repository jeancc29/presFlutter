

class Contacto {
  int id;
  String telefono;
  String extension;
  String celular;
  String fax;
  String correo;
  String facebook;
  String instagram;
  

  Contacto({this.id, this.telefono, this.extension, this.celular, this.fax, this.correo, this.facebook, this.instagram});

  Contacto.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        telefono = snapshot['telefono'] ?? '',
        extension = snapshot['extension'] ?? '',
        celular = snapshot['celular'] ?? '',
        fax = snapshot['fax'] ?? '',
        correo = snapshot['correo'] ?? '',
        facebook = snapshot['facebook'] ?? '',
        instagram = snapshot['instagram'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "telefono": telefono,
      "extension": extension,
      "celular": celular,
      "fax": fax,
      "correo": correo,
      "facebook": facebook,
      "instagram": instagram,
    };
  }
}