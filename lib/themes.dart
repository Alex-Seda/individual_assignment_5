import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.blue.shade700,
    primary: Colors.blue.shade400,
    secondary: Colors.blue.shade200,
  ),
);

ThemeData DarkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.purple.shade800,
    primary: Colors.purple.shade600,
    secondary: Colors.purple.shade400,
  ),
);