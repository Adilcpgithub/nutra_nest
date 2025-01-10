import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData.light().copyWith(
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black), // Change bodyText1 color
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white), // Change bodyText1 color
  ),
);
