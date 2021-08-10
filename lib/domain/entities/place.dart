import 'package:flutter/foundation.dart';
import 'package:moyori/extension/math.dart';

@immutable
class Place {
  const Place({
    required this.name,
    required this.lat,
    required this.lon,
    required this.iconUrl,
    this.photoUrl,
    this.rating,
    required this.vicinity,
  });

  final String name;
  final double lat;
  final double lon;
  final String iconUrl;
  final String? photoUrl;
  final double? rating;
  final String vicinity;

  double distance(double lat, double lon) {
    return distanceBetween(this.lat, this.lon, lat, lon);
  }
}
