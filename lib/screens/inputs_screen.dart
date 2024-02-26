import 'package:flutter/material.dart';
import 'package:practica3/theme/app_theme.dart';

class Inputsscreen extends StatefulWidget {
  const Inputsscreen({super.key});

  @override
  State<Inputsscreen> createState() => _InputsscreenState();
}

class _InputsscreenState extends State<Inputsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entradas')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text('Inputs/Entradas',style:AppTheme.lightTheme.textTheme.headlineLarge),
             const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                onPressed: null,
                child: Text('regresar',),
                ),
                ElevatedButton(
                onPressed: null,
                child: Text('Ir a data screen',), 
                ),
              ],
            )
        ],
      ),
    );
  }
}