import 'package:moyori/domain/entities/place.dart';
import 'package:moyori/infrastructure/web/core/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_place_list.g.dart';

@JsonSerializable(createToJson: false)
class SearchPlaceListWebErrorResponse extends WebResponse {
  const SearchPlaceListWebErrorResponse();
  factory SearchPlaceListWebErrorResponse.fromJson(Map<String, dynamic> json) => _$SearchPlaceListWebErrorResponseFromJson(json);
  @JsonKey(name: 'error_message')
  final String? errorMessage = null;

  @JsonKey(name: 'status')
  final String? errorStatus = null;

  void validate() {
    if (errorStatus != null) {
      throw Exception();
    } 
  }
}

@JsonSerializable(createToJson: false)
class SearchPlaceListWebResponse extends WebResponse {
  const SearchPlaceListWebResponse({required this.placeList});
  factory SearchPlaceListWebResponse.fromJson(Map<String, dynamic> json) => _$SearchPlaceListWebResponseFromJson(json);
  
  @JsonKey(name: 'results')
  final List<_PlaceInformation> placeList;

  List<Place> toPlaceList() => placeList.map((place) => Place(
    name: place.name,
    lat: place.geometry.location.lat,
    lon: place.geometry.location.lon,
    iconUrl: place.iconUrl,
    photoUrl: place.photos?[0].photoUrl,
    rating: place.rating,
    vicinity: place.vicinity,
  )).toList();
}

@JsonSerializable(createToJson: false)
class _PlaceInformation {
  _PlaceInformation({
    required this.name, 
    required this.geometry,
    this.photos,
    required this.iconUrl,
    this.rating,
    required this.vicinity,
  });
  factory _PlaceInformation.fromJson(Map<String, dynamic> json) => _$_PlaceInformationFromJson(json);

  final String name;
  final _PlaceGeometry geometry;
  final List<_PlacePhotos>? photos;
  @JsonKey(name: 'icon')
  final String iconUrl;
  final double? rating;
  final String vicinity;
}

@JsonSerializable(createToJson: false)
class _PlacePhotos{
  _PlacePhotos({
    required this.width,
    required this.height,
    required this.reference
  });
  factory _PlacePhotos.fromJson(Map<String, dynamic> json) => _$_PlacePhotosFromJson(json);
  final int width;
  final int height;
  @JsonKey(name: 'photo_reference')
  final String reference;
  String get photoUrl => "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$width&maxheight=$height&photoreference=$reference&key=";
}

@JsonSerializable(createToJson: false)
class _PlaceGeometry {
  _PlaceGeometry({
    required this.location,
  });
  factory _PlaceGeometry.fromJson(Map<String, dynamic> json) => _$_PlaceGeometryFromJson(json);
  final _PlaceLocation location;
}

@JsonSerializable(createToJson: false)
class _PlaceLocation {
  _PlaceLocation({
    required this.lat, 
    required this.lon,
  });
  factory _PlaceLocation.fromJson(Map<String, dynamic> json) => _$_PlaceLocationFromJson(json);
  final double lat;
  @JsonKey(name: 'lng')
  final double lon;
}
