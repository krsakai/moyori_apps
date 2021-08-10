import 'dart:async';
import 'dart:math';
import 'package:moyori/extension/math.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocationMapPageModel with ChangeNotifier {
  PlaceLocationMapPageModel({required this.currentLocation, required this.targetLocation, required this.name});
  final Point<double> currentLocation;
  final Point<double> targetLocation;
  final String name;

  LatLng get target => LatLng((currentLocation.x + targetLocation.x) / 2, (currentLocation.y + targetLocation.y) / 2);

  double get zoom {
    final max = 24;
    final distance = distanceBetween(currentLocation.x, currentLocation.y, targetLocation.x, targetLocation.y);
    if (0 < distance && distance <= 20) {
      return max - 3;
    } else if (20 < distance && distance <= 50) {
      return max - 4;
    } else if (50 < distance && distance <= 100) {
      return max - 5;
    } else if (100 < distance && distance <= 200) {
      return max - 6;
    } else if (200 < distance && distance <= 500) {
      return max - 7;
    } else if (500 < distance && distance <= 1000) {
      return max - 8;
    } else if (1000 < distance && distance <= 2000) {
      return max - 9;
    } else if (1000 < distance && distance <= 2000) {
      return max - 10;
    } else if (2000 < distance && distance <= 5000) {
      return max - 11;
    } else if (5000 < distance && distance <= 10000) {
      return max - 12;
    } else if (10000 < distance && distance <= 20000) {
      return max - 13;
    } else {
      return max - 14;
    } 
  }

  Set<Marker> get markers => {
    Marker(markerId: MarkerId("x"), position: LatLng(targetLocation.x, targetLocation.y))
  };

  Completer<GoogleMapController> _controller = Completer();

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
