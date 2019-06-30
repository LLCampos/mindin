import 'package:flutter/material.dart';

class MindInTheme {
  static ThemeData getThemeData() {
    return ThemeData(
        backgroundColor: Color(0xfff7efd2),
        primaryColor: Color(0xff8f886e),
        primaryColorDark: Color(0xff7c765c),
        buttonColor: Color(0xff7c765c),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        textTheme: new TextTheme(
          button: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
          body1: new TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xff7c765c)
          )
        )
    );
  }
}
