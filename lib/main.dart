import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Você esta abaixo do peso ideal - (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.5 && imc <= 24.9){
        _infoText = "Parabéns, voce esta com o peso ideal - (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 25.0 && imc <= 29.9){
        _infoText = "Atenção, voce esta com sobrepeso - (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 30.0 && imc <= 34.9){
        _infoText = "Atenção, OBESIDADE GRAU 1 - (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 35.0 && imc <= 39.9){
        _infoText = "Atenção, OBESIDADE GRAU 2 - (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40.0){
        _infoText = "Atenção, OBESIDADE GRAU 3 - (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.redAccent,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              )
            ],
          ),
        ),
      )
    );
  }
}
