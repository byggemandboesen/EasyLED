import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Boolean that stores if dark mode is on or off
bool isLightTheme = true;
// Function that updates the light/dark mode boolean with new value
// Reassigns new bool value in "Shared preferences" to load either light/dark when opening app
updateTheme() async {
  isLightTheme = !isLightTheme;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLightTheme', isLightTheme);
}

//---------------------------------COLORS-------------------------------------//

// TODO: Fix ugly color theme
Color themeBlue = Color.fromRGBO(0, 170, 255, 1);
Color themeOrange = Color.fromRGBO(255, 85, 0, 1);

Color redLight = Color.fromRGBO(255, 0, 0, 1);
Color greenLight = Color.fromRGBO(0, 255, 0, 1);
Color blueLight = Color.fromRGBO(0, 0, 255, 1);

//---------------------------------THEMES-------------------------------------//

// Light theme uses default black as text color except for Appbar title
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      color: themeOrange,
      iconTheme: IconThemeData(
          color: themeBlue
      ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 30),
    )
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 25),
    subtitle1: TextStyle(fontSize: 20),
    subtitle2: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 15)
  ),
);


// Dark theme uses primary color as text
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
      color: themeBlue,
      iconTheme: IconThemeData(
          color: themeOrange
      ),
  ),
  textTheme: TextTheme(
      headline1: TextStyle(fontSize: 25, color: themeBlue),
      subtitle1: TextStyle(fontSize: 20, color: themeBlue),
      subtitle2: TextStyle(fontSize: 15, color: themeBlue, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 15, color: themeBlue)
  ),
);