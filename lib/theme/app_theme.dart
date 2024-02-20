
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  //declaracion de color 
  static const mainColor = Color.fromARGB(255, 28, 94, 94);
  static const backColor = Color.fromARGB(255, 152, 188, 224);

  static final ThemeData lightTheme =  ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
        appBarTheme: const AppBarTheme( color: mainColor),
        textTheme:TextTheme(
          headlineLarge: GoogleFonts.kalam(
            color: const Color.fromARGB(255, 54, 25, 59),
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: Colors.green[700],
            decorationStyle: TextDecorationStyle.dotted,
            decorationThickness: 3.0,
            fontStyle:  FontStyle.italic
            ),
            bodySmall: GoogleFonts.pacifico(
              color: const Color.fromARGB(255, 30, 38, 92),
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              decoration: TextDecoration.underline,
              decorationColor: Colors.limeAccent[700],
              decorationStyle: TextDecorationStyle.wavy,
              decorationThickness:  2.0,
              fontStyle: FontStyle.italic
            )
        )
  );
}