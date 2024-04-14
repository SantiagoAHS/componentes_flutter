import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Authentication
import 'package:practica3/services/firebase_services.dart';
import 'package:practica3/theme/app_theme.dart';

class PaymentRecordsScreen extends StatefulWidget {
  @override
  _PaymentRecordsScreenState createState() => _PaymentRecordsScreenState();
}

class _PaymentRecordsScreenState extends State<PaymentRecordsScreen> {
  List<Map<String, dynamic>> _userPayments = [];

  @override
  void initState() {
    super.initState();
    _loadUserPayments();
  }

  Future<void> _loadUserPayments() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Accede al usuario actual desde Firebase Authentication
      if (user != null) {
        String userId = user.uid;
        // Obtener los pagos asociados al usuario actual
        List<Map<String, dynamic>> userPayments = await FirebaseService.getUserPayments(userId);
        setState(() {
          _userPayments = userPayments;
        });
      }
    } catch (e) {
      print('Error al cargar los pagos del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros de Pagos'),
      ),
      body: Stack(
        children: [
          WaveBackground(), // Agrega el fondo de ola
          ListView.builder(
            itemCount: _userPayments.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> payment = _userPayments[index];
              int parkingSpaceIndex = payment['parkingSpaceIndex'];
              int elapsedTimeInSeconds = payment['elapsedTimeInSeconds'];
              DateTime timestamp = payment['timestamp'].toDate();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pago $index',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Espacio de estacionamiento: $parkingSpaceIndex'),
                        Text('Tiempo transcurrido: $elapsedTimeInSeconds segundos'),
                        Text('Fecha y hora: $timestamp'),
                      ],
                    ),
                  ),
                ),
              );
            },
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
