import 'package:flutter/material.dart';
import 'package:practica3/theme/app_theme.dart';

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
              leading: const Icon(Icons.input_sharp, color: AppTheme.mainColor),
              title:Text('Entradas',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: Text('Mostrar diferentes widgets para entradas de flutter ',
              style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing:const Icon(Icons.arrow_drop_down_circle, color: AppTheme.mainColor,),
            ),
            const Divider(color: Color.fromARGB(255, 47, 69, 195),),
             ListTile(
              leading: const Icon(Icons.list_sharp, color: AppTheme.mainColor),
              title:Text('ListViews.builder ',
              style: Theme.of(context).textTheme.headlineLarge,),
              subtitle:  Text('Scroll infinito',
              style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: const Icon(Icons.arrow_drop_down_circle, color: AppTheme.mainColor, ),
            ),
            const Divider(color: Color.fromARGB(255, 22, 98, 61)),
            ListTile(
              leading: const Icon(Icons.notification_add,
              color: AppTheme.mainColor),
              title:Text('Notificaciones ',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: Text('crear notificaciones',
              style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing:const Icon(Icons.arrow_drop_down_circle, color: AppTheme.mainColor,),
            ),
          ],
        )
      );
  }
}