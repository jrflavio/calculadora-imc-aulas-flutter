import 'package:flutter/material.dart';
import 'package:calculadora_imc/person.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  Pessoa _pessoa = Pessoa();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    _handleRadioValueChange(-1);
    setState(() {
      _pessoa.result = 'Informe seus dados';
      _pessoa.resultadoa = "";
      _pessoa.color = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            buttonClear(context);
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          sexButton(),
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  void calculateImc() {
    _pessoa.peso = double.parse(_weightController.text);
    _pessoa.altura = double.parse(_heightController.text) / 100.0;

    _pessoa.resultado = _pessoa.calcularImc();

    setState(() {
      if (_resulta == 1) {
        _pessoa.classMasc();
      } else if (_resulta == 2) {
        _pessoa.classFem();
      } else {
        msgErro(context);
      }
    });
  }

  // state variable
  int _resulta = 0;
  int _radioValue;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _resulta = 1;
          break;
        case 1:
          _resulta = 2;
          break;
      }
    });
  }

  buttonClear(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
         _resulta = 0;
        resetFields();
        Navigator.of(context).pop();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("APAGAR"),
      content: Text("Realmente deseja apagar os dados da consulta?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void msgErro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("ERRO"),
          content: new Text("Selecione o Gênero."),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget sexButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.01),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'Masculino',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'Feminino',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ]),
    );
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

/* Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
       _pessoa.result,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: _pessoa.color, ),
      ),
    );
  }
  */

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            _pessoa.resultadoa,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23.5),
          ),
          new Text(
            _pessoa.result,
            style: TextStyle(
              color: _pessoa.color, fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
