import 'package:flutter/material.dart';

class MindInTheme {
  static ThemeData getThemeData() {
    return ThemeData(
        backgroundColor: Colors.teal[200],
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )));
  }
}
