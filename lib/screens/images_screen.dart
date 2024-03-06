import 'package:flutter/material.dart';
import 'package:practica3/theme/app_theme.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
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

  Widget imageWeb(){
    return Center(
      child: Image.network('https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZULFYGMPg0IGkmogo1G0TA.jpeg'),
    );
  }
}