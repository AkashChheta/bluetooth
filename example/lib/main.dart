import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bluetooth/bluetooth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    new Bluetooth().on();
                  },
                  child: Text("On")),
              FlatButton(
                  onPressed: () {
                    new Bluetooth().off();
                  },
                  child: Text("off")),
            ],
          ),
        ),
      ),
    );
  }
}
