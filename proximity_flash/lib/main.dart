import 'dart:async';

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:light/light.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFlashOn = false;
  late Light _light;
  late StreamSubscription _lightSubscription;

  @override
  void initState() {
    super.initState();
    _initializeLightSensor();
  }

  void _initializeLightSensor() {
    _light = Light();
    try {
      _lightSubscription = _light.lightSensorStream.listen((luxValue) {
        debugPrint('Nivel de luz detectado: $luxValue lux');
        _handleLightChange(luxValue);
      });
    } catch (e) {
      debugPrint('Error al inicializar el sensor de luz: $e');
    }
  }

  void _handleLightChange(int luxValue) {
    // Define un umbral para encender/apagar el flash
    const int threshold = 10; // Cambia este valor según las pruebas
    if (luxValue < threshold && !_isFlashOn) {
      _turnOnFlash();
    } else if (luxValue >= threshold && _isFlashOn) {
      _turnOffFlash();
    }
  }

  void _turnOnFlash() async {
    try {
      await TorchLight.enableTorch();
      setState(() {
        _isFlashOn = true;
      });
    } catch (e) {
      debugPrint('Error al encender el flash: $e');
    }
  }

  void _turnOffFlash() async {
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
    _lightSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Controlado por Luz'),
      ),
      body: Center(
        child: Text(
          _isFlashOn ? 'Flash Encendido' : 'Flash Apagado',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
