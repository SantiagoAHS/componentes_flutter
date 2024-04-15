import 'package:flutter/material.dart';
import 'package:practica3/screens/terminos.dart';
import 'package:practica3/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);


  void navigateToTerminate(BuildContext context) {
    // Navega a la pantalla de registro
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TerminosPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: Stack(
        children: [
          // Fondo dual con efecto de ola
          WaveBackground(),
          Center( // Centrar el contenido verticalmente
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido verticalmente
                crossAxisAlignment: CrossAxisAlignment.center, // Centrar el contenido horizontalmente
                children: [
                  Image.asset(
                    'assets/imgs/logo.png', // Ruta de la imagen del logo
                    width: 200, // Tamaño de la imagen
                    height: 100,
                  ),
                  const SizedBox(height: 20), // Espacio entre la imagen y el texto
                  const Text(
                    '¿Necesitas ayuda?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Si tienes alguna pregunta o necesitas ayuda, no dudes en contactarnos:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Correo electrónico:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'evoparkinfo@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Teléfono:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '+522471385294',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => navigateToTerminate(context),
                    child: const Text('Terminos y Politicas'),
                    style: TextButton.styleFrom(
                      primary: const Color.fromARGB(255, 12, 21, 90), // Cambia el color del texto
                      textStyle: const TextStyle(fontSize: 16), // Cambia el tamaño del texto
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Ajusta el padding
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Da forma redondeada al botón
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Síguenos en nuestras redes sociales:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.facebook),
                        onPressed: () {
                          // Agrega la lógica para abrir Facebook aquí
                        },
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.twitter),
                        onPressed: () {
                          // Agrega la lógica para abrir Twitter aquí
                        },
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.instagram),
                        onPressed: () {
                          // Agrega la lógica para abrir Instagram aquí
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo dual con gradiente lineal
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.fondo1,
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
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
  runApp(const MaterialApp(
    home: Scaffold(
      body: HelpScreen(),
    ),
  ));
}
