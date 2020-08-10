import 'package:easyled/BlueTooth/BlueToothFunctions.dart';
import 'package:flutter/material.dart';

import 'package:easyled/BlueTooth/ConnectScreen.dart';


class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyLED', style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bluetooth),
            iconSize: 30,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => bluetoothConnectScreen()));
            },
          )
        ],
      ),
    );
  }
}


