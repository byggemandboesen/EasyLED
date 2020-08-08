import 'package:easyled/ThemeData.dart';

import 'package:flutter/material.dart';


class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}
// TODO: Fix the appbar title style with theme
class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isLightTheme ? lightTheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyLED'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: isLightTheme ? Icon(Icons.brightness_3) : Icon(Icons.brightness_7),
              iconSize: 30,
              onPressed: (){
                setState(() {
                  updateTheme();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

