import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class NetworkStatus {
  bool isConnected = false;
  String connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  // ignore: cancel_subscriptions
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  init() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isConnected = true;
        connectionStatus = result.toString();
        break;
      case ConnectivityResult.none:
        isConnected = false;
        connectionStatus = result.toString();
        break;
      default:
        isConnected = false;
        connectionStatus = "Unknown";
        break;
    }
  }
}