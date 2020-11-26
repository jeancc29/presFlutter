import 'dart:math';

import 'package:prestamo/core/classes/utils.dart';
import 'package:prestamo/core/models/amortizacion.dart';
import 'package:prestamo/core/models/dia.dart';
import 'package:prestamo/core/models/tipo.dart';

class AmortizationService{
  static List<Amortizacion> amortizacionFrances({double monto, double interes, int numeroCuota, Tipo tipoPlazo, DateTime fechaPrimerPago}){
    // double i = interes / 100;
    fechaPrimerPago = (fechaPrimerPago == null) ? DateTime.now() : fechaPrimerPago;
    print("AmortizacionService amortizacionFrances fechaPrimerPago: ${fechaPrimerPago.toString()}");
    double i = convertirInteres(interes: interes, tipoPlazo: tipoPlazo, convertirAAnos: false) / 100;
    double cuotaCalculadaAPagar = monto * ((i * (pow(1+i, numeroCuota))) / ((pow((1+i), numeroCuota)) - 1) );
    cuotaCalculadaAPagar = Utils.redondear(cuotaCalculadaAPagar);
    print("AmortizacionService amortizacionFrances monto: $monto interes:  $i cuota: $numeroCuota");
    
    List<Amortizacion> lista = List();
    for(int index = 0; index < numeroCuota; index++) {
      double montoInteres = 0;
      double montoCapital = 0;
      double montoCuota = 0;
      double capitalRestante = 0;
      double capitalSaldado = 0;

      if(index == 0){
        montoInteres =  Utils.redondear((monto * i));
        montoCapital = Utils.redondear(cuotaCalculadaAPagar - montoInteres);
        montoCuota = cuotaCalculadaAPagar;
        capitalRestante = monto - montoCapital;
        capitalSaldado = montoCapital;
        lista.add(Amortizacion(cuota: montoCuota, interes: montoInteres, capital: montoCapital, capitalSaldado: capitalSaldado, capitalRestante: capitalRestante, fecha: fechaPrimerPago));
      }else{
        print("AmortizacionService frances: ${index} length: ${lista.length}");
        print("AmortizacionService frances: ${lista[index - 1].capitalRestante}");
        montoInteres = Utils.redondear(lista[index - 1].capitalRestante * i);
        montoCapital = Utils.redondear(cuotaCalculadaAPagar - montoInteres);
        montoCuota = cuotaCalculadaAPagar;
        capitalRestante = Utils.redondear(lista[index - 1].capitalRestante - montoCapital);
        capitalSaldado = Utils.redondear(lista[index - 1].capitalRestante + montoCapital);

        if((index + 1) == numeroCuota){
          montoCapital = Utils.redondear(_sumarORestarMontoSobranteAlCapital(capitalRestante, montoCapital));
          montoInteres = Utils.redondear(_sumarORestarMontoSobranteAlInteres(capitalRestante, montoInteres));
          capitalRestante = 0;
        }
        lista.add(Amortizacion(cuota: montoCuota, interes: montoInteres, capital: montoCapital, capitalSaldado: capitalSaldado, capitalRestante: capitalRestante, fecha: aumentarFecha(fecha: lista[index - 1].fecha, dayOfTheMonthToAmortize: lista[0].fecha.day, tipoPlazo: tipoPlazo)));
      }

      
    }
    lista.forEach((element) {print("pagado: ${element.capitalSaldado} restante: ${element.capitalRestante} cuota: ${element.cuota} capital: ${element.capital} interes: ${element.interes}");});
    // print("resultado _amortizacionFrances: $r");
    // print("resultado i _amortizacionFrances: $i - ${pow((1+i), cuota) - 1}");
    return lista;
  }

  static double _sumarORestarMontoSobranteAlInteres(double capitalRestante, montoInteres){
    if(capitalRestante > 0){
      montoInteres = montoInteres - capitalRestante;
    }
    else if(capitalRestante < 0)
      montoInteres = montoInteres + capitalRestante.abs();

    print("amortizationservice _sumarORestarMontoSobranteAlInteres montoInteres: $montoInteres restante: $capitalRestante");
    return montoInteres;
  }

  static double _sumarORestarMontoSobranteAlCapital(double capitalRestante, montoCapital){
    if(capitalRestante > 0){
      montoCapital = montoCapital + capitalRestante;
    }
    else if(capitalRestante < 0)
      montoCapital = montoCapital - capitalRestante.abs();

    print("amortizationservice _sumarORestarMontoSobranteAlCapital montoCapital: $montoCapital restante: $capitalRestante");
    return montoCapital;
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

  static aumentarFecha({Tipo tipoPlazo, DateTime fecha, List<Dia> listaDiasExcluidos, int dayOfTheMonthToAmortize}){
    switch (tipoPlazo.descripcion) {
      case "Diario":
        if(listaDiasExcluidos == null)
          fecha = fecha.add(Duration(days: 1));
        else{
          bool esDiaExcluido = false;
          fecha = fecha.add(Duration(days: 1));
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Semanal":
        if(listaDiasExcluidos == null)
          fecha = fecha.add(Duration(days: 7));
        else{
          bool esDiaExcluido = false;
          fecha = fecha.add(Duration(days: 7));
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Bisemanal":
        if(listaDiasExcluidos == null)
          fecha = fecha.add(Duration(days: 14));
        else{
          bool esDiaExcluido = false;
          fecha = fecha.add(Duration(days: 14));
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Quincenal":
        if(listaDiasExcluidos == null)
          fecha = fecha.add(Duration(days: 15));
        else{
          bool esDiaExcluido = false;
          fecha = fecha.add(Duration(days: 15));
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "15 y fin de mes":
        if(listaDiasExcluidos == null){
          if(fecha.day < 15){
            int diasFaltantesParaLlegarAlDia15 = 15 - fecha.day;
            fecha = fecha.add(Duration(days: diasFaltantesParaLlegarAlDia15));
          }else{
            fecha = Utils.getLastDayOfMonth(fecha);
          }
        }
        else{
          bool esDiaExcluido = false;
          if(fecha.day < 15){
            int diasFaltantesParaLlegarAlDia15 = 15 - fecha.day;
            fecha = fecha.add(Duration(days: diasFaltantesParaLlegarAlDia15));
          }else{
            fecha = Utils.getLastDayOfMonth(fecha);
          }
          while(!esDiaExcluido){
            fecha = fecha.add(Duration(days: 7));
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Mensual":
      //Debo guardar el dia exacto de la amortizacion asi al momento de que 
      //el dia de cada mes sea 31 y el siguiente mes sea 28 entonces el otro 
      //siguiente mes debe caer 31 y no 28
        if(listaDiasExcluidos == null){
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize);
        }
        else{
          bool esDiaExcluido = false;
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize);
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Anual":
        if(listaDiasExcluidos == null)
          fecha = new DateTime(fecha.year + 1, fecha.month, fecha.day);
        else{
          bool esDiaExcluido = false;
          fecha = new DateTime(fecha.year + 1, fecha.month, fecha.day);
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Trimestral":
        if(listaDiasExcluidos == null){
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize, monthsToAdd: 3);
        }
        else{
          bool esDiaExcluido = false;
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize, monthsToAdd: 3);
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      case "Semestral":
        if(listaDiasExcluidos == null){
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize, monthsToAdd: 6);
        }
        else{
          bool esDiaExcluido = false;
          fecha = Utils.getNextMonth(fecha, dayOfTheMonth: dayOfTheMonthToAmortize, monthsToAdd: 6);
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
        break;
      default:
        if(listaDiasExcluidos == null){
          DateTime lastDayOfMonth = Utils.getLastDayOfMonth(fecha);
          if(fecha.day != lastDayOfMonth.day)
            fecha = lastDayOfMonth;
          else{
            fecha = Utils.getNextMonth(fecha);
          }
        }
        else{
          bool esDiaExcluido = false;
          DateTime lastDayOfMonth = Utils.getLastDayOfMonth(fecha);
          if(fecha.day != lastDayOfMonth.day)
            fecha = lastDayOfMonth;
          else{
            fecha = Utils.getNextMonth(fecha);
          }
          while(!esDiaExcluido){
            esDiaExcluido = (listaDiasExcluidos.indexWhere((element) => element.weekday == fecha.weekday) != -1);
            if(esDiaExcluido)
              fecha = fecha.add(Duration(days: 1));
          }
        }
    }

    return fecha;
  }
  
}