import 'package:flutter/material.dart';
import 'package:practica3/screens/login.dart';
import 'package:practica3/screens/primer.dart';
import 'package:practica3/theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrimerScreen(),
      theme: AppTheme.lightTheme,
    );
  }
}
