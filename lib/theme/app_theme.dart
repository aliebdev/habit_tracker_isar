import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade500,
          secondary: Colors.grey.shade200,
          tertiary: Colors.white,
          inversePrimary: Colors.grey.shade900,
        ),
        useMaterial3: false,
      );
  static ThemeData get dark => ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade600,
          secondary: Colors.grey.shade700,
          tertiary: Colors.grey.shade800,
          inversePrimary: Colors.grey.shade300,
        ),
        useMaterial3: false,
      );
}
