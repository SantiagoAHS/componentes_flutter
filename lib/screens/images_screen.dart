import 'package:flutter/material.dart';
import 'package:practica3/screens/inputs_screen.dart';
import 'package:practica3/theme/app_theme.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:practica3/screens/home_screen.dart';
import 'package:practica3/screens/infinite_list_screen.dart';
import 'package:practica3/screens/notifications_screen.dart';


class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
   int selectedIndex = 0;
  List screens =const [
    HomeScreen(),
    InfiniteListScreen(),
    NotificationsScreen(),
    Inputsscreen(),
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
        case 3:ruta =MaterialPageRoute(builder: (context)=> const Inputsscreen());
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
        title: Text('Imagnes',style: AppTheme.lightTheme.textTheme.headlineLarge,),
      ),
      body: ListView(
        children: [
          imageCard(),
          imageWeb(),
        ]),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex : selectedIndex,
        backgroundColor: const Color.fromARGB(255, 16, 255, 255),
        unselectedItemColor: AppTheme.mainColor,
        onTap: (index) => openScreen(index),
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Color.fromARGB(221, 2, 0, 0),), label: "Inicio",),
          BottomNavigationBarItem(icon: Icon(Icons.data_object,color: Colors.black87,), label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.notification_add_outlined, color: Colors.black87,), label: "Noti"),
          BottomNavigationBarItem(icon: Icon(Icons.list, color: Colors.black87,), label: "Imgs"),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app, color: Colors.black87,), label: "Salida",)
        ],
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.headlineSmall,
      ),
    );
  }

  Card imageCard(){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(20),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            const Image(
                  image: AssetImage('assets/imgs/d5.jpg'),
                ),
            Container(
              padding: const EdgeInsets.all(10),
              child:Text("Paisaje Japones",style: AppTheme.lightTheme.textTheme.bodySmall,),
            ),
          ],
        ),
      ),
    );
  }

  Stack imageWeb(){
    return Stack(
      children: <Widget>[
        const Center(
            child: CircularProgressIndicator()
        ),
        Center(
          child: SizedBox(
            height: 250,
            width: 350,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, 
              image: 'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZULFYGMPg0IGkmogo1G0TA.jpeg')
            //Image.network()
            //para mostrar una imangen de la web
            ),
        ),
      ],
    );
  }
}