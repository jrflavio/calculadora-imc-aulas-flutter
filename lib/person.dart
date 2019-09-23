import 'package:flutter/material.dart';
import 'package:calculadora_imc/main.dart';

class Pessoa{
String result;
String resulta;
String resultadoa="";
double resultado;

int sexo;
double peso, altura;
Color color = Colors.black;

Pessoa({this.sexo,this.peso,this.altura,this.result, this.resultado});

calcularImc(){
  double calcimc;

  calcimc = this.peso / (this.altura * this.altura);
  resultado = calcimc;
  
  return calcimc;
}
classMasc(){
  result = "";
      if (resultado < 20.7){
        result += "Abaixo do peso";
        color = Colors.lightBlue[300];
      }
      else if (resultado < 26.4){
        result += "Peso ideal";
        color = Colors.green[300];
}
      else if (resultado < 27.8){
        result += "Levemente acima do peso";
        color = Colors.orange[300];
      }
      else if (resultado < 31.1){
        result += "Acima do peso";
        color = Colors.teal;
      }
      else if (resultado > 31.1){
        result += "Obesidade";
        color = Colors.red[300];
      }
      resultadoa = "IMC = ${resultado.toStringAsPrecision(4)}";
      
}
void classFem(){
   result = "";
   if (resultado < 19.1){
        result += "Abaixo do peso";
        color = Colors.lightBlue[300];
      }
      else if (resultado < 25.8){
        result += "Peso ideal";
        color = Colors.green[300];
}
      else if (resultado < 27.3){
        result += "Levemente acima do peso";
        color = Colors.orange[300];
      }
      else if (resultado < 32.3){
        result += "Acima do peso";
        color = Colors.teal;
      }
      else if (resultado > 32.3){
        result += "Obesidade";
        color = Colors.red[300];
      }
        resultadoa = "IMC = ${resultado.toStringAsPrecision(4)}";
}
 String classificar({double imc}) {

    if (imc < 18.5)
      return "Abaixo do peso";
    else if (imc < 25.0)
      return "Peso normal";
    else if (imc < 30.0)
      return "Sobrepeso";
    else if (imc < 35.0)
      return "Obesidade grau 1";
    else if (imc < 40.0)
      return "Obesidade grau 2";
    else
      return "Obesidade grau 3";
  }


}