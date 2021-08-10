import 'dart:math';

double distanceBetween(double latA, double lonA, double latB, double lonB) {
  final toRadians = (double degree) => degree * pi / 180;
  final double r = 6378137.0; // 地球の半径
  final double f1 = toRadians(latA);
  final double f2 = toRadians(latB);
  final double l1 = toRadians(lonA);
  final double l2 = toRadians(lonB);
  final num a = pow(sin((f2 - f1) / 2), 2);
  final double b = cos(f1) * cos(f2) * pow(sin((l2 - l1) / 2), 2);
  final double d = 2 * r * asin(sqrt(a + b));
  return d;
}