import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Componentes de flutter'),
        
      ),
        body: ListView(
          children: [
            const Divider(),
            ListTile(
              leading: const Icon(Icons.auto_fix_high_outlined,),
              title:Text('Hola a todos los kawasakis 1',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: const Text('Hola esto es un subtitulo'),
              trailing:const Icon(Icons.arrow_drop_down_circle,),
            ),
            const Divider(color: Color.fromARGB(255, 47, 69, 195),),
            const ListTile(
              leading: Icon(Icons.accessibility_new, ),
              title:Text('Hola a todos los kawasakis 2',
              ),
              subtitle: Text('Hola esto es un subtitulo'),
              trailing:Icon(Icons.arrow_drop_down_circle, ),
            ),
            const Divider(color: Color.fromARGB(255, 22, 98, 61)),
            const ListTile(
              leading: Icon(Icons.alt_route,),
              title:Text('Hola a todos los kawasakis 3',),
              subtitle: Text('Hola esto es un subtitulo'),
              trailing:Icon(Icons.arrow_drop_down_circle,),
            ),
          ],
        )
      );
  }
}