import 'package:easyled/ThemeData.dart';
import 'package:easyled/BlueTooth/BlueToothFunctions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class bluetoothConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect', style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
      ),
      body: mainBody(),
    );
  }
}

class mainBody extends StatefulWidget {
  @override
  _mainBodyState createState() => _mainBodyState();
}

class _mainBodyState extends State<mainBody> {

  List<ScanResult> availableDevices = [];

  @override
  void initState() {
    // Instance of flutter blue
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 2));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult deviceFound in results) {
        print('${deviceFound.device.name} found! rssi: ${deviceFound.rssi}');
      }
    });

    // Stop scanning
    flutterBlue.stopScan();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: defaultMargin,
                child: Text('Bluetooth-devices',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 40,
              onPressed: (){
                setState(() {
                  availableDevices.clear();
                });
              },
            )
          ],
        ),
        showDevices()
      ],
    );
  }

  Widget showDevices(){
    if (availableDevices.isEmpty ||availableDevices == null){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.2,
        margin: defaultMargin,
        child: Center(
          child: Text('No devices found...',
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: availableDevices.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            child: deviceCard(
                availableDevices[index].device.name,
                availableDevices[index].device.id.toString()
            ),
            onTap: () async{
              try{
                await availableDevices[index].device.connect();
                showDialog(
                  context: context,
                  child: alertDialog('Connected sucessfully to ${availableDevices[index].device.name}')
                );
              }
              catch(err){
                showDialog(
                  context: context,
                  child: alertDialog(err.toString())
                );
              }
            },
          );
        },
      ),
    );
  }
}

// AlertDialog shows a successful connection message or the thrown error
class alertDialog extends StatelessWidget {

  // Error or success-message
  alertDialog(this.message);
  String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(message,style: Theme.of(context).textTheme.bodyText1,),
        actions: <Widget>[
          FlatButton(
            highlightColor: Theme.of(context).accentColor,
            child: Text('OK', style: Theme.of(context).textTheme.subtitle2,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  }
}

// Card for each device name and rssi
class deviceCard extends StatelessWidget {

  // Required data to pass to the card widget with bluetooth devices
  deviceCard(this.cardTitle, this.cardSubTitle);

  String cardTitle;
  String cardSubTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: defaultMargin,
      elevation: 7.5,
      shadowColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).accentColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(cardTitle, style: Theme.of(context).textTheme.subtitle2,),
        leading: Icon(Icons.bluetooth),
        subtitle: Text(cardSubTitle, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}

