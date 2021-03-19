import 'package:flutter/material.dart';

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.green, primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode _focusWeight;
  FocusNode _focusHeight;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double imc = 0;

  @override
  void initState() {
    super.initState();

    _focusWeight = FocusNode();
    _focusHeight = FocusNode();
    _focusWeight.unfocus();
    _focusHeight.unfocus();
  }

  @override
  void dispose() {
    _focusWeight.dispose();
    _focusHeight.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Calculadora de IMC'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshValues)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      focusNode: _focusWeight,
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Peso (Kg)'),
                      validator: (weight) {
                        if (weight.isEmpty) return 'Preencha o valor do peso!';
                        return null;
                      }),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                      focusNode: _focusHeight,
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Altura (m)'),
                      validator: (height) {
                        if (height.isEmpty)
                          return 'Preencha o valor da altura!';
                        return null;
                      }),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text(
                      "Calcular",
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Seu IMC é: ${imc.toStringAsFixed(2)}"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 0.0),
                      child: Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: imc != 0 && imc < 18.5
                                      ? Colors.green
                                      : Colors.white),
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    height: 32.0,
                                    alignment: Alignment.center,
                                    child: Text("< 18,5")),
                                Container(
                                    height: 32.0,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("Abaixo do Peso")),
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: imc >= 18.5 && imc < 24.9
                                      ? Colors.green
                                      : Colors.white),
                              children: [
                                Container(
                                    height: 32.0,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("18,5 - 24,9")),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    height: 32.0,
                                    child: Text("Ideal"))
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: imc >= 25.0 && imc < 29.9
                                      ? Colors.green
                                      : Colors.white),
                              children: [
                                Container(
                                  height: 32.0,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text("25,0 - 29,9"),
                                ),
                                Container(
                                    height: 32.0,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("Sobrepeso"))
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: imc >= 30.0 && imc < 34.9
                                      ? Colors.green
                                      : Colors.white),
                              children: [
                                Container(
                                    height: 32.0,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("30,0 - 34,9")),
                                Container(
                                    height: 32.0,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("Obesidade grau 1"))
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: imc > 35.0 && imc < 39.9
                                      ? Colors.green
                                      : Colors.white),
                              children: [
                                Container(
                                    height: 32.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    alignment: Alignment.center,
                                    child: Text("35,0 - 39,9")),
                                Container(
                                    height: 32.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Obesidade severa grau 2"))
                              ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color:
                                      imc > 40.0 ? Colors.green : Colors.white),
                              children: [
                                Container(
                                    height: 32.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    alignment: Alignment.center,
                                    child: Text("> 40")),
                                Container(
                                    height: 32.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Obesidade móbida grau 3"))
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _calculate() {
    if (_formKey.currentState.validate()) {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      setState(() {
        imc = weight / (height * height);
      });
    }
  }

  void _refreshValues() {
    setState(() {
      _weightController.text = "";
      _focusWeight.unfocus();
      _heightController.text = "";
      _focusHeight.unfocus();
      imc = 0.0;
      _formKey.currentState.reset();
    });
  }
}
