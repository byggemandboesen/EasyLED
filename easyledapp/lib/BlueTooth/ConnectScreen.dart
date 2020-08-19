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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30,),
          onPressed: (){
            FlutterBlue.instance.stopScan();
            Navigator.pop(context);
          },
        ),
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
          width: 350,
          height: 60,
          margin: defaultMargin,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Theme.of(context).accentColor, blurRadius: 5)]
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: TextField(
              decoration:  InputDecoration(
                  hintText: 'Search for device',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  prefixIcon: Icon(Icons.bluetooth, color: Theme.of(context).accentColor, size: 20),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor),),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor)),
              ),
              onChanged: (value) {
                // TODO: Filter bluetooth list
              },
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
    flutterBlue.startScan();

    return Expanded(
      child: StreamBuilder(
        stream: flutterBlue.scanResults,
        builder: (context, snapshots){
          if(snapshots.data == null || snapshots.data.length == 0){
            return Column(
              children: <Widget>[
                CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Finding bluetooth devices...',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data == null ? 0 : snapshots.data.length,
            itemBuilder: (context, index){
              return InkWell(
                child: deviceCard(
                    snapshots.data[index].device.name,
                    snapshots.data[index].device.id.toString(),
                    snapshots.data[index].rssi.toString()
                ),
                onTap: () async{
                  flutterBlue.stopScan();
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
  deviceCard(this.cardTitle, this.cardSubTitle, this.deviceRSSI);

  String cardTitle;
  String cardSubTitle;
  String deviceRSSI;

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
        trailing: Text('RSSI: $deviceRSSI dBm', style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  // Checks if the device' name is null or ''
  String checkUknownName(){
    return cardTitle == '' || cardTitle == null ? 'Unkown name' : cardTitle;
  }

}

