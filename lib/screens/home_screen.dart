import 'package:flutter/material.dart';
import 'package:practica3/screens/images_screen.dart';
import 'package:practica3/screens/infinite_list_screen.dart';
import 'package:practica3/screens/inputs_screen.dart';
import 'package:practica3/screens/notifications_screen.dart';
import 'package:practica3/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List screens =const [
    HomeScreen(),
    InfiniteListScreen(),
    NotificationsScreen(),
    ImagesScreen(),
  ];

  openScreen(int index){
    setState(() {
      MaterialPageRoute ruta= MaterialPageRoute(builder: (context)=> const HomeScreen());
      switch(index){
        case 0:ruta = MaterialPageRoute(builder: (context)=> const HomeScreen());
          break;
        case 1:ruta =MaterialPageRoute(builder: (context)=> const InfiniteListScreen());
          break;
        case 2:ruta = MaterialPageRoute(builder: (context)=> const NotificationsScreen());
          break;
        case 3:ruta =MaterialPageRoute(builder: (context)=> const ImagesScreen());
          break;
    }
      selectedIndex = index;
      Navigator.push(
        context, 
        ruta
        );
    });
  }

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
            const Divider(color: Color.fromARGB(255, 22, 98, 61)),
            ListTile(
              leading: IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.image),),
                title: Text('Imagenes', style: AppTheme.lightTheme.textTheme.headlineLarge,),
                 subtitle: Text('Widgest de manejo de imagenes',
              style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
                trailing:IconTheme(
                data: AppTheme.lightTheme.iconTheme,
                child: const Icon(Icons.arrow_drop_down_circle,)),
                onTap: () {
                final ruta4 = MaterialPageRoute(builder: (context){
                  return const ImagesScreen();
                });
                Navigator.push(context, ruta4);
              },  
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex : selectedIndex,
        backgroundColor: const Color.fromARGB(255, 16, 255, 255),
        unselectedItemColor: AppTheme.mainColor,
        onTap: (index) => openScreen(index),
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Color.fromARGB(221, 2, 0, 0),), label: "Inicio",),
          BottomNavigationBarItem(icon: Icon(Icons.data_object,color: Colors.black87,), label: "data"),
          BottomNavigationBarItem(icon: Icon(Icons.notification_add_outlined, color: Colors.black87,), label: "Noti"),
          BottomNavigationBarItem(icon: Icon(Icons.image_search_outlined, color: Colors.black87,), label: "Imgs"),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app, color: Colors.black87,), label: "Salida",)
        ],
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.headlineSmall,
      ),
      );
  }
}