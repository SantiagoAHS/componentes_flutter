import 'package:flutter/material.dart';
import 'package:practica3/screens/infinite_list_screen.dart';
import 'package:practica3/screens/inputs_screen.dart';
import 'package:practica3/screens/notifications_screen.dart';
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
              leading: IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child:const Icon(Icons.input_sharp),),
              title:Text('Entradas',
              style: AppTheme.lightTheme.textTheme.headlineLarge,
              ),
              subtitle: Text('Mostrar diferentes widgets para entradas de flutter ',
              style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              //OPCIONES CIRCULARES INDICATOR
              //trailing: const CircularProgressIndicator(
                //value: 0.15,
                //semanticsLabel: 'prueba',
                //strokeWidth: 5.5,
                //color: AppTheme.mainColor,
                //backgroundColor: Colors.deepOrangeAccent,
              //),
              trailing:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.arrow_drop_down_circle,)),
              onTap: () {
                final ruta1 = MaterialPageRoute(builder: (context){
                  return const Inputsscreen();
                });
                Navigator.push(context, ruta1);
              },
            ),
            const Divider(color: Color.fromARGB(255, 47, 69, 195),),
             ListTile(
              leading:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.list_sharp,)),
              title:Text('ListViews.builder ',
              style: AppTheme.lightTheme.textTheme.headlineLarge),
              subtitle:  Text('Scroll infinito',
              style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              trailing:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.arrow_drop_down_circle,)),
              onTap: () {
                final ruta2 = MaterialPageRoute(builder: (context){
                  return const InfiniteListScreen();
                });
                Navigator.push(context, ruta2);
              },
            ),
            const Divider(color: Color.fromARGB(255, 22, 98, 61)),
            ListTile(
              leading:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.notification_add,)),
              title:Text('Notificaciones ',
              style: AppTheme.lightTheme.textTheme.headlineLarge,
              ),
              subtitle: Text('crear notificaciones',
              style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              trailing:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.arrow_drop_down_circle,)),
              onTap: () {
                final ruta3 = MaterialPageRoute(builder: (context){
                  return const NotificationsScreen();
                });
                Navigator.push(context, ruta3);
              },
            ),
          ],
        )
      );
  }
}