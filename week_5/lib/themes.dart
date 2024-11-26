import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const TextTheme _lightTextTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
  );
  static const TextTheme _darkTextTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  );
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    hintColor: const Color(0xFFFFD301),
    textTheme: _lightTextTheme,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFFFD301),
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    hintColor: const Color(0xFFFFD301),
    textTheme: _darkTextTheme,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFFFD301),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
