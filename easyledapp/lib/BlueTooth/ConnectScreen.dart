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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: defaultMargin,
          child: Center(
            child: Text('Bluetooth-devices:',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        showDevices()
      ],
    );
  }
}

class showDevices extends StatefulWidget {
  @override
  _showDevicesState createState() => _showDevicesState();
}

class _showDevicesState extends State<showDevices> {
  @override
  Widget build(BuildContext context) {

    // Instance of flutter blue
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 2));

    return Expanded(
      child: StreamBuilder(
        stream: flutterBlue.scanResults,
        builder: (context, snapshots){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data == null ? 0 : snapshots.data.length,
            itemBuilder: (context, index){
              return InkWell(
                child: deviceCard(
                  snapshots.data[index].device.name,
                  snapshots.data[index].device.id.toString(),
                ),
                onTap: () async{
                  String connectStatus = await blueFunctions().connectToDevice(snapshots.data[index].device);
                  showDialog(
                      context: context,
                      child: alertDialog(connectStatus)
                  );
                },
              );
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
        title: Text('Device name - ${checkUknownName()}', style: Theme.of(context).textTheme.subtitle2,),
        leading: Icon(Icons.bluetooth),
        subtitle: Text('Device ID - $cardSubTitle', style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // Checks if the device' name is null or ''
  String checkUknownName(){
    return cardTitle == '' || cardTitle == null ? 'Unkown name' : cardTitle;
  }

}

