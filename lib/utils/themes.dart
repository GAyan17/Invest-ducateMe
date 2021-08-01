import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  cardTheme: CardTheme(
    elevation: 8.0,
    shadowColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
  ),
);
