
import 'package:flutter/material.dart';

class AppTheme{
  //declaracion de color 
  static const mainColor = Color.fromARGB(255, 77, 222, 222);
  static const backColor = Color.fromARGB(255, 65, 127, 190);

  static final ThemeData lightTheme =  ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
        appBarTheme: const AppBarTheme( color: mainColor),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: mainColor,          fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'sans-serif'
            )
        )
  );
}