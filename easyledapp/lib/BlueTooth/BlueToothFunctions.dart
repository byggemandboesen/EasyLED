import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class blueFunctions{

  Future<String> connectToDevice(BluetoothDevice device) async{
    try{
      await device.connect();
      return 'Connected successfully!';
    }
    catch(err){
      return err.toString();
    }
  }

}