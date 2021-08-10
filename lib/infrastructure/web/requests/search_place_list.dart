import 'package:moyori/infrastructure/web/core/request.dart';

class SearchPlaceListWebRequest extends WebRequest {
  final double lat;
  final double lon;
  final String searchWord;
  final String? placeType;

  SearchPlaceListWebRequest({required this.lat, required this.lon, required this.searchWord, this.placeType});

  @override
  final String path = '/maps/api/place/nearbysearch/json';

  @override
  final HttpMethod httpMethod = HttpMethod.get;

  @override
  final Map<String, String> httpHeaders = {};

  @override
  final dynamic data = null;

  @override
  Map<String, dynamic> get queryParameters => {
    "location": lat.toString() + "," + lon.toString(),
    "language": "ja",
    "rankby": "distance",
    "type": placeType ?? "",
    "keyword": searchWord,
    "key": const String.fromEnvironment("GOOGLE_API_KEY")
  };
}
