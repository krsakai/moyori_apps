import 'dart:math';

class PlaceLocationMapPageArguments {
  const PlaceLocationMapPageArguments({
    required this.currentLocation,
    required this.targetLocation,
    required this.name,
  });
  
  final Point<double> currentLocation;
  final Point<double> targetLocation;
  final String name;
}
