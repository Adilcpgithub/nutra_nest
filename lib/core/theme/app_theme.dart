import 'package:flutter/material.dart';

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
      ? Colors.white
      : Colors.black;
}

Color appTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.black
      : Colors.white;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
