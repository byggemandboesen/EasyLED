import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//---------------------------------COLORS-------------------------------------//

Color defaultBlue = Color.fromRGBO(0, 12, 46, 1);
Color defaultOrange = Color.fromRGBO(238, 178, 116, 1);

Color redLight = Color.fromRGBO(255, 0, 0, 1);
Color greenLight = Color.fromRGBO(0, 255, 0, 1);
Color blueLight = Color.fromRGBO(0, 0, 255, 1);

//-------------------------------EDGEINSETS-----------------------------------//

EdgeInsets defaultMargin = EdgeInsets.symmetric(horizontal: 10, vertical: 20);

//---------------------------------THEME--------------------------------------//


ThemeData defaultTheme = ThemeData(
    primaryColor: defaultBlue,
    accentColor: defaultOrange,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: defaultBlue,
      iconTheme: IconThemeData(
          color: defaultOrange
      ),
  ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 30, color: defaultOrange, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 20, color: Colors.white),
      subtitle2: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 15, color: Colors.white)
  ),
    iconTheme: IconThemeData(
    color: defaultOrange,
  ),
    cardTheme: CardTheme(
      color: defaultBlue,
      shadowColor: defaultOrange,
    )
);