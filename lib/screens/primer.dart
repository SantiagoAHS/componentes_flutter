import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practica3/screens/login.dart';
import 'package:practica3/theme/app_theme.dart';

class PrimerScreen extends StatefulWidget {
  @override
  _PrimerScreenState createState() => _PrimerScreenState();
}

class _PrimerScreenState extends State<PrimerScreen> {
  bool _showImage = false;

  @override
  void initState() {
    super.initState();
    // Inicia un temporizador para mostrar la imagen durante 2 segundos
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showImage = true; // Cambia el estado para mostrar la imagen
      });
      // Navega a la pantalla de inicio de sesión después de otros 2 segundos
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo dual con gradiente lineal
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.mainColor,
                  AppTheme.accent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 0.7],
              ),
            ),
          ),
          // Efecto de ola en la parte superior del fondo
          Positioned.fill(
            top: -100,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.backColor.withOpacity(0.6),
                      AppTheme.backColor.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: _showImage
                      ? Image.asset(
                          'assets/imgs/logo.png', // Ruta de la imagen que deseas mostrar
                          key: const Key('image'), // Clave para identificar el widget durante la animación
                          fit: BoxFit.contain,
                          height: 200, // Ajusta el tamaño de la imagen según sea necesario
                        )
                      : const CircularProgressIndicator(), // Muestra un indicador de carga antes de mostrar la imagen
                ),
                const SizedBox(height: 80), // Espacio entre la imagen y el nombre del creador
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Evopark Company', // Reemplaza "Tu Nombre" con tu nombre
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Clase para definir el clipper para el efecto de ola
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: PrimerScreen(),
    ),
  ));
}
