import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Colores principales
  final Color mainColor = const Color(0xFF212936);
  final Color secondColor = const Color(0xFF2849E5);

  // Variables de estado
  final List<String> units = ["Centímetros", "Kilómetros", "Pies", "Yardas"];
  String from = "Metros";
  String to = "Centímetros";
  double convertedValue = 0.0;

  // Controlador del TextField
  final TextEditingController inputController = TextEditingController();

  // Función para realizar la conversión
  void convert() {
    final inputValue = double.tryParse(inputController.text);
    if (inputValue == null) {
      // Manejo de entrada no válida
      setState(() {
        convertedValue = 0.0;
      });
      return;
    }

    double result;
    switch (to) {
      case "Centímetros":
        result = inputValue * 100;
        break;
      case "Kilómetros":
        result = inputValue / 1000;
        break;
      case "Pies":
        result = inputValue * 3.28084;
        break;
      case "Yardas":
        result = inputValue * 1.09361;
        break;
      default:
        result = inputValue;
    }

    setState(() {
      convertedValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Conversor de Distancias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Campo de entrada
                      TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Distancia en Metros",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: secondColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20.0),
                      // Dropdowns para seleccionar unidades
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Desde
                          DropdownButton<String>(
                            value: from,
                            dropdownColor: mainColor,
                            items: ["Metros"].map((unit) {
                              return DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  unit,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          const Text(
                            "a",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Hacia
                          DropdownButton<String>(
                            value: to,
                            dropdownColor: mainColor,
                            items: units.map((unit) {
                              return DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  unit,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                to = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // Botón para convertir
                      ElevatedButton(
                        onPressed: convert,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondColor,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 15.0,
                          ),
                        ),
                        child: const Text(
                          "Convertir",
                          style: TextStyle(fontSize: 18.0,
                          color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Resultado
                      Text(
                        "Resultado: $convertedValue $to",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
