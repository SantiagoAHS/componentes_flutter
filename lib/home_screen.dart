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
          children: const [
            Divider(),
            ListTile(
              leading: Icon(Icons.auto_fix_high_outlined, color: Color.fromARGB(255, 47, 69, 195),),
              title:Text('Hola a todos los kawasakis 1',
              style: TextStyle(color: Color.fromARGB(255, 47, 69, 195), fontWeight: FontWeight.bold, fontSize: 25.0),),
              subtitle: Text('Hola esto es un subtitulo'),
              trailing:Icon(Icons.arrow_drop_down_circle, color: Color.fromARGB(255, 47, 69, 195)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.accessibility_new, color: Colors.greenAccent,),
              title:Text('Hola a todos los kawasakis 2',
              style: TextStyle(color: Color.fromARGB(255, 47, 229, 156), fontWeight: FontWeight.bold, fontSize: 22.0),),
              subtitle: Text('Hola esto es un subtitulo'),
              trailing:Icon(Icons.arrow_drop_down_circle, color: Colors.greenAccent),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.alt_route, color: Color.fromARGB(255, 180,16 , 112),),
              title:Text('Hola a todos los kawasakis 3',
              style: TextStyle(color: Color.fromARGB(255, 180, 16, 112), fontWeight: FontWeight.bold, fontSize: 20.0),),
              subtitle: Text('Hola esto es un subtitulo'),
              trailing:Icon(Icons.arrow_drop_down_circle,color: Colors.blueGrey, ),
            ),
          ],
        )
      );
  }
}