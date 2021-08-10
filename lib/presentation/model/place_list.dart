import 'package:moyori/domain/entities/place.dart';
import 'package:moyori/domain/repositories/place.dart';
import 'package:flutter/material.dart';

class PlaceListPageModel with ChangeNotifier, RouteAware {
  PlaceListPageModel({
    required this.placeRepository,
    required this.lat,
    required this.lon,
    required this.searchWord,
    this.placeType
  });

  final PlaceRepository placeRepository;
  final double lat;
  final double lon;
  final String searchWord;
  final String? placeType;
  bool isLoading = false;
  bool isNetworkError = false;

  List<Place> placeList = [];

  Future<void> initialize() async {
    await fetchPlaceList();
  }

  Future<void> fetchPlaceList() async {
    try {
      notifyListeners();
      isLoading = true;
      isNetworkError = false;
      placeList = await placeRepository.placeList(lat: lat, lon: lon, searchWord: searchWord, placeType: placeType);
    } on Exception catch (exception) {
      isNetworkError = true;
      throw exception;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSpotInfo() {
    placeList = <Place>[];
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