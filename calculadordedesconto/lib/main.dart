import 'package:flutter/material.dart';

void main() async{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyWidget(),
    theme: ThemeData(
      hintColor: Colors.black,
      primaryColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textColor)),
        // hintStyle: TextStyle(color: black),
      ),
      // scaffoldBackgroundColor: Colors.backgroundColor,
    ),
  ));
}


class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _info = "Informe os valores:";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final codClientController = TextEditingController();
  final totalValueController = TextEditingController();

  void _resetFields() {
    codClientController.text = "";
    totalValueController.text = "";
    setState(() {
      _info = "Informe os valores:";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      String inputText = codClientController.text;
      double totalValue = double.parse(totalValueController.text);

      int desconto;
      double percentage;
      double finalValue;
      double discount;
      if (inputText == '3') {
        percentage = 0.05;
        desconto = 5;

        discount = totalValue * percentage;
        finalValue = totalValue - discount;
        _info =
            "Desconto recebido: ${desconto}% \n\n Como cliente VIP, o valor final do produto é: R\$${finalValue.toInt()}";
      } else if (inputText == '2') {
        percentage = 0.10;
        desconto = 10;

        discount = totalValue * percentage;
        finalValue = totalValue - discount;
        _info =
            "Desconto recebido: ${desconto}% \n\n Como funcionário, o valor final do produto é: R\$${finalValue.toInt()}";
      } else if (inputText == '1') {
        desconto = 0;

        finalValue = totalValue;
        _info =
            "Desconto recebido: ${desconto}% \n\n Como cliente regular, o valor final do produto é: R\$${finalValue.toInt()}";
      } else {
        // Mostra o Alerta
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            // Configura o AlertDialog
            return AlertDialog(
              title: const Text("ERRO!"),
              content: const Text("Este código não consta no sistema. :("),
              actions: [
                // Configura o botão de fechar
                ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    // Fecha o AlertDialog
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: const Text("Calcula desconto"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.local_offer, size: 120.0, color: Colors.white),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Código",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: codClientController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o seu código!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: totalValueController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Informe o valor!";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcular();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                    ),
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 25.0),
                )
              ],
            ),
          ),
        ),
      );
  }
}
