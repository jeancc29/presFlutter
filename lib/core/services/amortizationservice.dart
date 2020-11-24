import 'dart:math';

import 'package:prestamo/core/models/amortizacion.dart';
import 'package:prestamo/core/models/tipo.dart';

class AmortizationService{
  static amortizacionFrances({double monto, double interes, int cuota, Tipo tipoPlazo}){
    // double i = interes / 100;
    double i = convertirInteres(interes: interes, tipoPlazo: tipoPlazo, convertirAAnos: false) / 100;
    double cuotaCalculadaAPagar = monto * ((i * (pow(1+i, cuota))) / ((pow((1+i), cuota)) - 1) );
    print("AmortizacionService amortizacionFrances monto: $monto interes:  $i cuota: $cuota");
    List<Amortizacion> lista = List();
    for(int index = 0; index < cuota; index++) {
      double montoInteres = 0;
      double montoCapital = 0;
      double montoCuota = 0;
      double capitalRestante = 0;
      double capitalSaldado = 0;

      if(index == 0){
        montoInteres =  monto * i;
        montoCapital = cuotaCalculadaAPagar - montoInteres;
        montoCuota = cuotaCalculadaAPagar;
        capitalRestante = monto;
        capitalSaldado = montoCapital;
        lista.add(Amortizacion(cuota: montoCuota, interes: montoInteres, capital: montoCapital, capitalSaldado: capitalSaldado, capitalRestante: capitalRestante));
      }

      montoInteres =  lista[index].capitalRestante * i;
      montoCapital = cuotaCalculadaAPagar - montoInteres;
      montoCuota = cuotaCalculadaAPagar;
      capitalRestante = lista[index].capitalRestante - montoCapital;
      capitalSaldado = montoCapital;
      lista.add(Amortizacion(cuota: montoCuota, interes: montoInteres, capital: montoCapital, capitalSaldado: capitalSaldado, capitalRestante: capitalRestante));
    }
    lista.forEach((element) {print("pagado: ${element.capitalSaldado}restante: ${element.capitalRestante} cuota: ${element.cuota} capital: ${element.capital} interes: ${element.interes}");});
    // print("resultado _amortizacionFrances: $r");
    // print("resultado i _amortizacionFrances: $i - ${pow((1+i), cuota) - 1}");
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