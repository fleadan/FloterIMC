import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMCs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCStateful(),
    );
  }
}
class IMCStateful extends StatefulWidget{
  @override
  IMCState createState() => IMCState();
}

class IMCState extends State<IMCStateful>{
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  GlobalKey<FormState> formEstado = GlobalKey<FormState>();
  String mensajes = "Bienvenido!!!";
  void reiniciar(){
    peso.text = "";
    altura.text = "";
    setState(() {
      mensajes = "Calcula tu IMC!";
    });
  }
  void calculaImc()
  {
    setState(() {
      double pesos = double.parse(peso.text);
      double alturas = double.parse(altura.text);
      double imc = pesos / (alturas * alturas);
      if( imc < 18.5){
        mensajes = "Peso Bajo (tu IMC es de : ${imc.toStringAsPrecision(2)})";
      } else if( imc >= 18.5 && imc <= 24.9){
        mensajes = "Peso Normal (tu IMC es de: ${imc.toStringAsPrecision(2)})";
      }else if( imc >= 25 && imc <= 29.9){
        mensajes = "Sobrepeso (tu IMC es de:  ${imc.toStringAsPrecision(2)})";
      }else if( imc >= 30 && imc <= 34.9){
        mensajes = "Obesidad Tipo 1 (tu IMC es de: ${imc.toStringAsPrecision(2)})";
      }else if( imc >= 35 && imc <= 39.9){
        mensajes = "Obesidad Tipo 2 (tu IMC es de: ${imc.toStringAsPrecision(2)})";
      }else if( imc >= 40){
        mensajes = "Obesidad Tipo 3 (tu IMC es de: ${imc.toStringAsPrecision(2)})";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC APP:"),
        backgroundColor: Colors.deepPurple.shade300,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reiniciar,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formEstado,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon( Icons.account_circle_outlined, size: 100.0, color: Colors.indigo.shade300),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso: ",
                    labelStyle: TextStyle(color: Colors.indigo.shade200)
                ),
                textAlign: TextAlign.center,
                controller: peso,
                style: TextStyle(color: Colors.indigo.shade200, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Ambos campos deben tener un valor";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Estatura en metros: ",
                    labelStyle: TextStyle(color: Colors.indigo.shade200)
                ),
                textAlign: TextAlign.center,
                controller: altura,
                style: TextStyle(color: Colors.indigo.shade200, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Ambos campos deben tener un valor";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formEstado.currentState.validate()) {
                        calculaImc();
                      }
                    },
                    child: Text(
                      "Obtener IMC",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.deepPurple.shade300,
                  ),
                ),
              ),
              Text(
                mensajes,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple.shade300, fontSize: 25.0),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}
