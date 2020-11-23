import 'dart:math';

import 'package:prestamo/core/models/tipo.dart';

class AmortizationService{
  static amortizacionFrances({double monto, double interes, double cuota}){
    double i = interes / 100;
    double r = monto * ((i * (pow(1+i, cuota))) / ((pow((1+i), cuota)) - 1) );
    print("resultado _amortizacionFrances: $r");
    print("resultado i _amortizacionFrances: $i - ${pow((1+i), cuota) - 1}");
  }

  static convertirInteres({Tipo tipoPlazo, double interes, bool convertirAAnos = true}){
    double interesARetornarl = 0;
    print("AmortizationService convertirInteres: ${tipoPlazo.descripcion}");
    switch (tipoPlazo.descripcion) {
      case "Diario":
        if(convertirAAnos)
          interesARetornarl = interes * 365;
        else
          interesARetornarl = interes / 365;
        break;
      case "Semanal":
        if(convertirAAnos)
          interesARetornarl = interes * 54;
        else
          interesARetornarl = interes / 54;
        break;
      case "Bisemanal":
        if(convertirAAnos)
          interesARetornarl = interes * 27;
        else
          interesARetornarl = interes / 27;
        break;
      case "Quincenal":
        if(convertirAAnos)
          interesARetornarl = interes * 24;
        else
          interesARetornarl = interes / 24;
        break;
      case "15 y fin de mes":
        if(convertirAAnos)
          interesARetornarl = interes * 24;
        else
          interesARetornarl = interes / 24;
        break;
      case "Mensual":
        if(convertirAAnos)
          interesARetornarl = interes * 12;
        else
          interesARetornarl = interes / 12;
        break;
      case "Anual":
          interesARetornarl = interes;
        break;
      case "Trimestral":
        if(convertirAAnos)
          interesARetornarl = interes * 4;
        else
          interesARetornarl = interes / 4;
        break;
      case "Semestral":
        if(convertirAAnos)
          interesARetornarl = interes * 2;
        else
          interesARetornarl = interes / 2;
        break;
      default:
        if(convertirAAnos)
          interesARetornarl = interes * 12;
        else
          interesARetornarl = interes / 12;
    }

    return interesARetornarl;
  }
  
}