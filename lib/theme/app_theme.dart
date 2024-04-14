import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Declaración de colores
  static const mainColor = Color.fromARGB(255, 85, 123, 204);
  static const backColor = Color.fromARGB(255, 226, 230, 235);
  static const accent = Color.fromARGB(255, 56, 79, 101);
  static const fondo1 = Color.fromARGB(255, 157, 179, 226);
  static const fondo2 = Color.fromARGB(252, 209, 212, 214);
  static const boton1 = Colors.blueGrey;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
    appBarTheme: AppBarTheme(
      color: mainColor,
      titleTextStyle: GoogleFonts.aBeeZee(
        color: backColor,
        fontSize: 28.5,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 17, 32, 100),
      size: 35.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(accent),
        foregroundColor: MaterialStateProperty.all(backColor),
        textStyle: MaterialStateProperty.all(
          GoogleFonts.aBeeZee(fontSize: 25.2),
        ),
      ),
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.aBeeZee(
        color: Colors.indigo[800],
        fontSize: 21.0,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: GoogleFonts.aBeeZee(
        color: Colors.indigo[800],
        fontSize: 20.0,
        fontWeight: FontWeight.w200,
      ),
    ),
  );
}
