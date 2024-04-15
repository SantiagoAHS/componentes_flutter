import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica3/theme/app_theme.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _nameController; 
  late TextEditingController _phoneNumberController;
  late TextEditingController _carModelController;
  late TextEditingController _carPlateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _carModelController = TextEditingController();
    _carPlateController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        DocumentSnapshot userDataSnapshot = await _firestore.collection('users').doc(userId).get();
        if (userDataSnapshot.exists) {
          Map<String, dynamic> userData = userDataSnapshot.data() as Map<String, dynamic>;
          setState(() {
            _nameController.text = userData['name'] ?? '';
            _phoneNumberController.text = userData['phoneNumber'] ?? '';
            _carModelController.text = userData['carModel'] ?? '';
            _carPlateController.text = userData['carPlate'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error al cargar los datos del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Perfil'),
      ),
      body: Stack(
        children: [
          WaveBackground(), // Fondo dual con efecto de o la
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 150, // Ajusta el tamaño del contenedor según sea necesario
                    height: 150, // Ajusta el tamaño del contenedor según sea necesario
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Forma circular
                      color: Colors.white, // Fondo blanco
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Color y opacidad de la sombra
                          spreadRadius: 5, // Radio de expansión de la sombra
                          blurRadius: 7, // Radio de desenfoque de la sombra
                          offset: Offset(0, 3), // Desplazamiento de la sombra
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: AppTheme.fondo2, // Color del icono de perfil
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Datos Personales:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(), // Agregar contorno al campo de texto
                    filled: true,
                    fillColor: AppTheme.fondo2,
                  ),
                  controller: _nameController,
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(), // Agregar contorno al campo de texto
                    filled: true,
                    fillColor: AppTheme.fondo2,
                  ),
                  controller: _phoneNumberController,
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Datos del Auto:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Modelo del Auto',
                    border: OutlineInputBorder(), // Agregar contorno al campo de texto
                    filled: true,
                    fillColor: AppTheme.fondo2,
                  ),
                  controller: _carModelController,
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Placa del Auto',
                    border: OutlineInputBorder(), // Agregar contorno al campo de texto
                    filled: true,
                    fillColor: AppTheme.fondo2,
                  ),
                  controller: _carPlateController,
                  style: const TextStyle(
                    color: Colors.black, // Cambia el color del texto en el campo de texto
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveDataToFirestore,
                    child: const Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                  primary: AppTheme.boton1, // Cambia el color de fondo del botón
                  textStyle: const TextStyle(fontSize: 16), // Cambia el tamaño del texto
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Ajusta el padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Da forma redondeada al botón
                ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveDataToFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        await _firestore.collection('users').doc(userId).set({
          'name': _nameController.text,
          'phoneNumber': _phoneNumberController.text,
          'carModel': _carModelController.text,
          'carPlate': _carPlateController.text,
        });
        print('Datos guardados exitosamente en Firestore');
      }
    } catch (e) {
      print('Error al guardar datos en Firestore: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _carModelController.dispose();
    _carPlateController.dispose();
    super.dispose();
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
