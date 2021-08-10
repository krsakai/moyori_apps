import 'package:moyori/domain/entities/place.dart';

abstract class PlaceRepository {
  Future<List<Place>> placeList({required double lat, required double lon, required String searchWord, String? placeType});
}