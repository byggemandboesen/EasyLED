import 'package:flutter/material.dart';

class bluetoothConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect', style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
      ),
    );
  }
}
