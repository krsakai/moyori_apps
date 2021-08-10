// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_place_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlaceListWebErrorResponse _$SearchPlaceListWebErrorResponseFromJson(
    Map<String, dynamic> json) {
  return SearchPlaceListWebErrorResponse();
}

SearchPlaceListWebResponse _$SearchPlaceListWebResponseFromJson(
    Map<String, dynamic> json) {
  return SearchPlaceListWebResponse(
    placeList: (json['results'] as List<dynamic>)
        .map((e) => _PlaceInformation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

_PlaceInformation _$_PlaceInformationFromJson(Map<String, dynamic> json) {
  return _PlaceInformation(
    name: json['name'] as String,
    geometry: _PlaceGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
    photos: (json['photos'] as List<dynamic>?)
        ?.map((e) => _PlacePhotos.fromJson(e as Map<String, dynamic>))
        .toList(),
    iconUrl: json['icon'] as String,
    rating: (json['rating'] as num?)?.toDouble(),
    vicinity: json['vicinity'] as String,
  );
}

_PlacePhotos _$_PlacePhotosFromJson(Map<String, dynamic> json) {
  return _PlacePhotos(
    width: json['width'] as int,
    height: json['height'] as int,
    reference: json['photo_reference'] as String,
  );
}

_PlaceGeometry _$_PlaceGeometryFromJson(Map<String, dynamic> json) {
  return _PlaceGeometry(
    location: _PlaceLocation.fromJson(json['location'] as Map<String, dynamic>),
  );
}

_PlaceLocation _$_PlaceLocationFromJson(Map<String, dynamic> json) {
  return _PlaceLocation(
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lng'] as num).toDouble(),
  );
}
