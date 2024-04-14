import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practica3/theme/app_theme.dart';

class TarjetaScreen extends StatefulWidget {
  const TarjetaScreen({Key? key}) : super(key: key);

  @override
  _TarjetaScreenState createState() => _TarjetaScreenState();
}

class _TarjetaScreenState extends State<TarjetaScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _numeroTarjetaController;
  late TextEditingController _nombreTitularController;
  late TextEditingController _fechaExpiracionController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    _loadTarjetaData();
    _numeroTarjetaController = TextEditingController();
    _nombreTitularController = TextEditingController();
    _fechaExpiracionController = TextEditingController();
    _cvvController = TextEditingController();
  }

  Future<void> _loadTarjetaData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        DocumentSnapshot tarjetaDataSnapshot = await _firestore.collection('tarjetas').doc(userId).get();
        if (tarjetaDataSnapshot.exists) {
          Map<String, dynamic> tarjetaData = tarjetaDataSnapshot.data() as Map<String, dynamic>;
          setState(() {
            _numeroTarjetaController.text = tarjetaData['numeroTarjeta'] ?? '';
            _nombreTitularController.text = tarjetaData['nombreTitular'] ?? '';
            _fechaExpiracionController.text = tarjetaData['fechaExpiracion'] ?? '';
            _cvvController.text = tarjetaData['cvv'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error al cargar la información de la tarjeta: $e');
    }
  }

  @override
  void dispose() {
    _numeroTarjetaController.dispose();
    _nombreTitularController.dispose();
    _fechaExpiracionController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la Tarjeta'),
      ),
      body: Stack(
        children: [
          WaveBackground(), // Fondo dual con efecto de ola
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número de Tarjeta',
                    border: OutlineInputBorder(),
                    filled: true, // Agregar fondo al campo de texto
                    fillColor: AppTheme.fondo2, // Color de fondo del campo de texto
                  ),
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  controller: _numeroTarjetaController,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Titular',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppTheme.fondo2,
                  ),
                  controller: _nombreTitularController,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Fecha de Expiración',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: AppTheme.fondo2,
                        ),
                        maxLength: 4,
                        keyboardType: TextInputType.datetime,
                        controller: _fechaExpiracionController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: AppTheme.fondo2,
                        ),
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        controller: _cvvController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center( // Centrar el botón "Guardar"
                  child: ElevatedButton(
                    onPressed: () {
                      _saveTarjetaDataToFirestore();
                    },
                    child: const Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                  primary: AppTheme.boton1, // Cambia el color de fondo del botón
                  textStyle: const TextStyle(fontSize: 16), // Cambia el tamaño del texto
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Ajusta el padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Da forma redondeada al botón
                ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveTarjetaDataToFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('tarjetas').doc(userId).set({
          'numeroTarjeta': _numeroTarjetaController.text,
          'nombreTitular': _nombreTitularController.text,
          'fechaExpiracion': _fechaExpiracionController.text,
          'cvv': _cvvController.text,
        });
        print('Información de la tarjeta guardada exitosamente en Firestore');
      }
    } catch (e) {
      print('Error al guardar información de la tarjeta en Firestore: $e');
    }
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
