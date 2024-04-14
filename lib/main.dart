import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica3/firebase_options.dart'; // Asegúrate de importar las opciones de Firebase adecuadas
import 'main_app.dart'; // Asumiendo que este es tu archivo principal

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}




