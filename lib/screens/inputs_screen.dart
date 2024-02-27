import 'package:flutter/material.dart';
import 'package:practica3/theme/app_theme.dart';

class Inputsscreen extends StatefulWidget {
  const Inputsscreen({super.key});

  @override
  State<Inputsscreen> createState() => _InputsscreenState();
}

class _InputsscreenState extends State<Inputsscreen> {
  bool valueSwitch = false;
  double valueSlider = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entradas')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Text('Inputs/Entradas',style:AppTheme.lightTheme.textTheme.headlineLarge),
            entradaTexto(),
            entradaSwitch(),
            entradaSlideer(),
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

  TextField entradaTexto() {
    return TextField(
            style: AppTheme.lightTheme.textTheme.headlineMedium,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              labelText: 'Escribe tu nombre',
              labelStyle: AppTheme.lightTheme.textTheme.headlineLarge,
              ),
          );
  }

  Row entradaSwitch(){
    return Row(
      children: <Widget>[
        Text('¿Te gusta flutter?', style: AppTheme.lightTheme.textTheme.headlineLarge,
        ),
        const SizedBox( width: 25.0,),
        Switch(
          value: valueSwitch, 
          onChanged: (value){
            setState(() {
              valueSwitch = value;
            });
        })
      ],
    );
  }

  Column entradaSlideer(){
    return Column(
      children: [
        Text('¿Que tanto te gusta flutter?', style: AppTheme.lightTheme.textTheme.headlineLarge,
        ),
        Slider(
          min: 0.0,
          max: 10.0,
          divisions: 10,
          value: valueSlider, 
          activeColor: const Color.fromARGB(255, 18, 66, 66),
          inactiveColor: const Color.fromARGB(255, 51, 214, 152),
          thumbColor: const Color.fromARGB(255, 94, 28, 192),
          label: '${valueSlider.round()}',
          onChanged: (value){
            setState(() {
              valueSlider = value;
              print('Valor del slider: $valueSlider');
            });
          })
      ],
    ); 
  }
}