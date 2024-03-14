import 'package:flutter/material.dart';
import 'package:practica3/screens/home_screen.dart';
import 'package:practica3/screens/images_screen.dart';
import 'package:practica3/screens/infinite_list_screen.dart';
import 'package:practica3/screens/inputs_screen.dart';
import 'package:practica3/screens/notifications_screen.dart';
import 'package:practica3/theme/app_theme.dart';



class DataScreen extends StatefulWidget {
  final InputData inputData;

  const DataScreen({Key? key, required this.inputData}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}
 
class _DataScreenState extends State<DataScreen> {
  

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
        title: const Text('Datos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Datos recibidos:', style: AppTheme.lightTheme.textTheme.headlineLarge,),
            Text(widget.inputData.toString(),
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              // Otros estilos que desees aplicar
            ),
           ), // Muestra los datos recibidos
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: const Color.fromARGB(255, 16, 255, 255),
        unselectedItemColor: Colors.black87,
        onTap: (index) => openScreen(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.data_usage), label: "Lista"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Imágenes"),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: "Salida"),
        ],
        unselectedLabelStyle: const TextStyle(fontSize: 12.0),
      ),
    );
  }
}