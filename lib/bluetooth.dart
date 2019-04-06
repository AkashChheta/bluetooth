import 'dart:async';

import 'package:flutter/services.dart';

enum Bluetoothstate {
  on,
  off,
  connected,
  discover,
}

class Bluetooth {
  static Bluetooth instance;
  final MethodChannel methodcall;
  final EventChannel eventcall;

  factory Bluetooth() {
    if (instance == null) {
      final MethodChannel _methodchannel = const MethodChannel('bluetooth');
      final EventChannel _eventchannel = const EventChannel("bluetoothstate");
      instance = new Bluetooth.call(_methodchannel, _eventchannel);
    }
    return instance;
  }

  Bluetooth.call(this.methodcall, this.eventcall);

  Future<bool> on() async {
    await methodcall.invokeMethod("on");
  }

  Future<bool> off() async {
    await methodcall.invokeMethod("off", {});
  }

  Future<List> get starradar async {
    await methodcall.invokeMethod("scan", {});
  }
}
