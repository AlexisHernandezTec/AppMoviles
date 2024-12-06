import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:torch_light/torch_light.dart'; // Import para manejar el flash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor de Proximidad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isNear = false;
  bool _isFlashOn = false; // Variable para rastrear el estado del flash
  late StreamSubscription<dynamic> _proximitySubscription;

  @override
  void initState() {
    super.initState();
    _initializeProximitySensor();
  }

  void _initializeProximitySensor() {
    try {
      _proximitySubscription = ProximitySensor.events.listen((int event) {
        debugPrint('Evento del sensor: $event');
        setState(() {
          // Convertir el evento entero a un booleano
          _isNear = event > 0;
          if (_isNear) {
            _turnOnFlash();
          } else {
            _turnOffFlash();
          }
        });
      });
    } catch (e) {
      debugPrint('Error al inicializar el sensor de proximidad: $e');
    }
  }

  Future<void> _turnOnFlash() async {
    try {
      await TorchLight.enableTorch();
      setState(() {
        _isFlashOn = true;
      });
    } catch (e) {
      debugPrint('Error al encender el flash: $e');
    }
  }

  Future<void> _turnOffFlash() async {
    try {
      await TorchLight.disableTorch();
      setState(() {
        _isFlashOn = false;
      });
    } catch (e) {
      debugPrint('Error al apagar el flash: $e');
    }
  }

  @override
  void dispose() {
    _proximitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor de Proximidad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isNear ? 'Cerca del sensor' : 'Lejos del sensor',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              _isFlashOn ? 'Flash encendido' : 'Flash apagado',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
