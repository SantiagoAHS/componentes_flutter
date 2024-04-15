import 'package:flutter/material.dart';
import 'package:practica3/theme/app_theme.dart';

class TerminosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: Stack(
        children: [
          // Fondo dual con efecto de ola
          WaveBackground(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Términos y Condiciones',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡Bienvenido/a a nuestra aplicación móvil de EvoParkMaster! Antes de comenzar, por favor, lee y acepta los siguientes términos y condiciones de uso. Al acceder y utilizar nuestra aplicación, aceptas cumplir con estos términos y condiciones en su totalidad. Si no estás de acuerdo con alguno de estos términos, te recomendamos que no utilices nuestra aplicación.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Uso de la Aplicación',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'a. Nuestra aplicación de EvoParkMaster está diseñada para permitir a los usuarios visualizar los datos relacionados con la optimización de espacio de uso automovilístico. La información y el contenido disponibles son únicamente para fines informativos y no constituyen asesoramiento comercial, financiero o profesional de ningún tipo. Al utilizar nuestra aplicación, aceptas utilizarla bajo tu propia responsabilidad y discreción.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'b. Te comprometes a utilizar la aplicación móvil únicamente para los fines previstos y de acuerdo con todas las leyes y regulaciones aplicables. Eres responsable de mantener la confidencialidad de tu información de inicio de sesión y de todas las actividades que ocurran bajo tu cuenta. Utiliza nuestra aplicación de manera legal y ética, respetando todas las leyes y regulaciones aplicables.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  Text(
                    'c. Te comprometes a utilizar la aplicación móvil únicamente para los fines previstos y de acuerdo con todas las leyes y regulaciones aplicables. Eres responsable de mantener la confidencialidad de tu información de inicio de sesión y de todas las actividades que ocurran bajo tu cuenta. Utiliza nuestra aplicación de manera legal y ética, respetando todas las leyes y regulaciones aplicables. Además, en caso de que la aplicación requiera el uso de cobros y/o datos bancarios para su correcto funcionamiento, te comprometes a proporcionar esta información de manera precisa y segura, aceptando que serás responsable de cualquier transacción realizada bajo tu cuenta.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
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
  runApp(MaterialApp(
    home: Scaffold(
      body: TerminosPage(),
    ),
  ));
}
