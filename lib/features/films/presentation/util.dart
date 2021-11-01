import 'package:flutter/material.dart';

class Util {

  //RETORNA A COR DA BARRA DE ACORDO COM A NOTA
  progressColorRange(double nota) {
    if (nota <= 30) {
      return Colors.redAccent;
    } else if (nota < 70 && nota > 30) {
      return Colors.yellowAccent;
    } else {
      return Colors.blue;
    }
  }

  //METODO PARA FORMATAR A DATA DOS FILMES
  String formatData(text) {
    String ano = text.toString().substring(0, 4);
    String dia = text
        .toString()
        .substring(text
        .toString()
        .length - 2, text
        .toString()
        .length);
    String mes = text.toString().substring(5, 7);

    switch (mes) {
      case '01':
        mes = "jan";
        break;
      case '02':
        mes = "fev";
        break;
      case '03':
        mes = "mar";
        break;
      case '04':
        mes = "abr";
        break;
      case '05':
        mes = "mai";
        break;
      case '06':
        mes = "jun";
        break;
      case '07':
        mes = "jul";
        break;
      case '08':
        mes = "ago";
        break;
      case '09':
        mes = "set";
        break;
      case '10':
        mes = "out";
        break;
      case '11':
        mes = "nov";
        break;
      case '12':
        mes = "dez";
        break;
    }
    return dia + ' de ' + mes + ' de ' + ano;
  }
}