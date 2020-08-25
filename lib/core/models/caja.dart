

class Caja {
  int id;
  String descripcion;
  String balanceInicial;
  String balance;
  String status;
  

  Caja({this.id, this.descripcion, this.balanceInicial, this.balance, this.status});

  Caja.fromMap(Map snapshot) :
        id = snapshot['id'] ?? 0,
        descripcion = snapshot['descripcion'] ?? '',
        balanceInicial = snapshot['balanceInicial'] ?? '',
        balance = snapshot['balance'] ?? '',
        status = snapshot['status'] ?? ''
        ;


  

  toJson() {
    return {
      "id": id,
      "descripcion": descripcion,
      "balanceInicial": balanceInicial,
      "balance": balance,
      "status": status,
    };
  }
}