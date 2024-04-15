import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practica3/screens/infinite_list_screen.dart';
import 'package:practica3/screens/registerlogin.dart';
import 'package:practica3/screens/terminos.dart';
import 'package:practica3/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // El usuario ha iniciado sesión exitosamente, redirigirlo a la pantalla HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InfiniteListScreen()), // Reemplaza la pantalla actual con HomeScreen
      );
    } catch (e) {
      print('Error al iniciar sesión: $e');
      // Mostrar un diálogo de error o realizar otras acciones según sea necesario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content: const Text('Hubo un error al intentar iniciar sesión. Por favor, verifica tus credenciales e intenta nuevamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void navigateToRegistration(BuildContext context) {
    // Navega a la pantalla de registro
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterLoginScreen()),
    );
  }

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
      body: Stack(
        children: [
          // Fondo dual con efecto de ola
          WaveBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/logo.png',
                height: 150, // Ajusta el tamaño de la imagen
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                    filled: true, // Agregar fondo al campo de texto
                    fillColor: AppTheme.fondo2, // Co
                  ),
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    filled: true, // Agregar fondo al campo de texto
                    fillColor: AppTheme.fondo2, // Co
                  ),
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => signInWithEmailPassword(context),
                child: const Text('Iniciar sesión'),
                style: ElevatedButton.styleFrom(
                  primary: AppTheme.boton1, // Cambia el color de fondo del botón
                  textStyle: const TextStyle(fontSize: 16), // Cambia el tamaño del texto
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Ajusta el padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Da forma redondeada al botón
                ),
              ),
              TextButton(
                onPressed: () => navigateToRegistration(context),
                child: const Text('Registrarse'),
                style: TextButton.styleFrom(
                  primary: const Color.fromARGB(255, 12, 21, 90), // Cambia el color del texto
                  textStyle: const TextStyle(fontSize: 16), // Cambia el tamaño del texto
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Ajusta el padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Da forma redondeada al botón
                ),
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 40), // Espacio entre la imagen y el nombre del creador
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Evopark Company', // Reemplaza "Tu Nombre" con tu nombre
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
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
      body: LoginScreen(),
    ),
  ));
}
