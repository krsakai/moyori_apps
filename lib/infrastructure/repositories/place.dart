import 'dart:async';
import 'dart:convert';
import 'package:moyori/domain/entities/place.dart';
import 'package:moyori/domain/repositories/place.dart';
import 'package:moyori/infrastructure/web/core/service.dart';
import 'package:moyori/infrastructure/web/requests/search_place_list.dart';
import 'package:moyori/infrastructure/web/responses/search_place_list.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 8,
    colors: true,
    printEmojis: false,
    printTime: false
  ),
);

class PlaceRepositoryImpl implements PlaceRepository {
  const PlaceRepositoryImpl({required this.webService});

  final WebService webService;

  @override
  Future<List<Place>> placeList({required double lat, required double lon, required String searchWord, String? placeType}) async {
    try {
      final SearchPlaceListWebRequest request = SearchPlaceListWebRequest(lat: lat, lon: lon, searchWord: searchWord, placeType: placeType);
      logger.d(request.queryParameters);
      final Response<dynamic> response = await webService.execute(request);
      logger.d(response.toString());
      SearchPlaceListWebErrorResponse.fromJson(response.data).validate();
      return SearchPlaceListWebResponse.fromJson(response.data).toPlaceList();
    } on Exception catch (exception) {
      throw exception;
    }
  }

  static dynamic decodeJson(String source) {
    return jsonDecode(source);
  }

  static String encodeJson(dynamic value) {
    return jsonEncode(value);
  }
}
