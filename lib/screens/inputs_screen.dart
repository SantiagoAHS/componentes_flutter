import 'package:flutter/material.dart';

class Inputsscreen extends StatefulWidget {
  const Inputsscreen({super.key});

  @override
  State<Inputsscreen> createState() => _InputsscreenState();
}

class _InputsscreenState extends State<Inputsscreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text('Inputs/Entradas',style:Theme.of(context).textTheme.headlineLarge,),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
              onPressed: null,
              child: Text('regresar', style: Theme.of(context).textTheme.headlineLarge,),
              ),
              ElevatedButton(
              onPressed: null,
              child: Text('Ir a data screen', style: Theme.of(context).textTheme.headlineLarge), 
              ),
            ],
          )
      ],
    );
  }
}