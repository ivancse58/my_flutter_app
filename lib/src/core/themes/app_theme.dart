import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    String fontFamily = "RobotoCondensed";

    return ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.amber,
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline2: TextStyle(
              fontSize: 22,
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: 20,
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              fontSize: 16,
              fontFamily: fontFamily,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            subtitle2: TextStyle(
              fontSize: 16,
              fontFamily: fontFamily,
              color: Colors.lightBlueAccent,
            ),
          ),
    );
  }
}
