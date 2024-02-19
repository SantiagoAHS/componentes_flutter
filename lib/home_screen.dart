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
              leading: const Icon(Icons.input_sharp,),
              title:Text('Entradas',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: const Text('Mostrar diferentes widgets para entradas de flutter '),
              trailing:const Icon(Icons.arrow_drop_down_circle,),
            ),
            const Divider(color: Color.fromARGB(255, 47, 69, 195),),
             ListTile(
              leading: const Icon(Icons.list_sharp, ),
              title:Text('ListViews.builder ',
              style: Theme.of(context).textTheme.headlineLarge,),
              subtitle: const Text('Scroll infinito'),
              trailing: const Icon(Icons.arrow_drop_down_circle, ),
            ),
            const Divider(color: Color.fromARGB(255, 22, 98, 61)),
            const ListTile(
              leading: Icon(Icons.notification_add,),
              title:Text('Notificaciones ',),
              subtitle: Text('crear notificaciones'),
              trailing:Icon(Icons.arrow_drop_down_circle,),
            ),
          ],
        )
      );
  }
}