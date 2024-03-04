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
  int selectedIndex = 0;
  int selectedRadioOption = 0; //para los Radios Botton
  bool selectedCheckBoxOption1 = false;
  bool selectedCheckBoxOption2 = false;
  bool selectedCheckBoxOption3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entradas')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              entradaTexto(),
              entradaSwitch(),
              entradaSlideer(),
              entradasRadio(),
              Text(
                'Que usas para correr tus app de flutter?',style: AppTheme.lightTheme.textTheme.headlineLarge,
                ),
              entradascheck(),
               const ElevatedButton(
               onPressed: null,
               child: Text('Guardar',), 
               )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex : selectedIndex,
        backgroundColor: const Color.fromARGB(255, 38, 160, 160),
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black87,), label: "Inicio",),
          BottomNavigationBarItem(icon: Icon(Icons.data_object,color: Colors.black87,), label: "Datos"),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app, color: Colors.black87,), label: "Salida")
        ],
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.headlineSmall,
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
        const FlutterLogo(
      
        ),
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
          label: '${valueSlider.round() }',
          onChanged: (value){
            setState(() {
              valueSlider = value;
              
            });
          })
      ],
    ); 
  }

  Column entradasRadio(){
    return Column(
      children: <Widget>[
        Text('¿Que prefieres usar para desarrollo movil?', style: AppTheme.lightTheme.textTheme.headlineLarge,),
        ListTile(
          title: Text('Kotlin', style: AppTheme.lightTheme.textTheme.headlineMedium,),
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 1, 
              groupValue:selectedRadioOption ,
              onChanged: (value){
              setState(() {
                selectedRadioOption = value!;
              });
            },),
          ),
        ),
        ListTile(
          title: Text('flutter', style: AppTheme.lightTheme.textTheme.headlineMedium,),
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 2, 
              groupValue:selectedRadioOption ,
              onChanged: (value){
              setState(() {
                selectedRadioOption = value!;
              });
            },),
          ),
        ),

      ],
    );
  }

  Row entradascheck(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Navegador',
          style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          Checkbox(
            value: selectedCheckBoxOption1, 
            onChanged: (value){
              setState(() {
                selectedCheckBoxOption1 = value!;
                print('Valor de navegador1: $selectedCheckBoxOption1');
              }
            );
          }
        ),
        Text(
          'Emulador',
          style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          Checkbox(
            value: selectedCheckBoxOption2, 
            onChanged: (value){
              setState(() {
                selectedCheckBoxOption2 = value!;
                print('Valor de navegador2: $selectedCheckBoxOption2');
              }
            );
          }
        ),
        Text(
          'Smartphone',
          style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          Checkbox(
            value: selectedCheckBoxOption3, 
            onChanged: (value){
              setState(() {
                selectedCheckBoxOption3 = value!;
                print('Valor de navegador3: $selectedCheckBoxOption3');
              }
            );
          }
        ),
      ],
    );
  }
}