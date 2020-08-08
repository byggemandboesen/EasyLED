import 'package:easyled/Screens/HomeScreen.dart';
import 'package:easyled/ThemeData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLightTheme = prefs.getBool('isLightTheme') ?? true;
  prefs.setBool('isLightTheme', isLightTheme);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(homeScreen());
}
