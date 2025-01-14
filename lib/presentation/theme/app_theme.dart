import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';

// Light Theme
ThemeData lightTheme = ThemeData.light().copyWith(
  textTheme: const TextTheme(
    displaySmall: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.black), // Change bodyText1 color
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  textTheme: const TextTheme(
    displaySmall: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.white), // Change bodyText1 color
  ),
);

bool isDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? true : false;
}

Color customTextTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? CustomColors.white
      : CustomColors.black;
}
