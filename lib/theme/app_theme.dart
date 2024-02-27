
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  //declaracion de color 
  static const mainColor = Color.fromARGB(255, 28, 94, 94);
  static const backColor = Color.fromARGB(255, 152, 188, 224);
  static const accent = Color.fromARGB(255, 11, 74, 137);
  

  static final ThemeData lightTheme =  ThemeData.light().copyWith(
    scaffoldBackgroundColor: backColor,
        appBarTheme:AppBarTheme( 
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
            backgroundColor:MaterialStateProperty.all(accent,),
            foregroundColor: MaterialStateProperty.all(backColor),
            textStyle: MaterialStateProperty.all(GoogleFonts.pacifico(fontSize: 25.2)),
          ),
        ),
        textTheme:TextTheme(
          headlineLarge: GoogleFonts.kalam(
            color: const Color.fromARGB(255, 91, 14, 67),
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: const Color.fromARGB(255, 95, 7, 76),
            decorationStyle: TextDecorationStyle.dotted,
            decorationThickness: 3.0,
            fontStyle:  FontStyle.italic
            ),
            bodySmall: GoogleFonts.pacifico(
              color: const Color.fromARGB(255, 30, 38, 92),
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              decoration: TextDecoration.underline,
            ),
            headlineMedium:GoogleFonts.kalam(
            color: mainColor,
            fontSize: 21.0,
            fontWeight: FontWeight.w500,
            decorationStyle: TextDecorationStyle.dotted,
            decorationThickness: 2.0,
            fontStyle:  FontStyle.italic
            ),

        )
  );
}