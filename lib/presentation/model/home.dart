import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:moyori/domain/entities/search_place.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class HomePageModel with ChangeNotifier, WidgetsBindingObserver {
  HomePageModel();
  String searchInputWord = "";
  Location locationService = Location();
  Geo.Position? myLocationData;
  StreamSubscription? locationChangedListen;
  bool get hasCurrentLocation => myLocationData != null;

  List<SearchPlace> searchPlaceList = [
    SearchPlace(searchWord: "カフェ", placeType: "cafe", iconData: Icons.local_cafe),
    SearchPlace(searchWord: "レストラン", placeType: "restaurant", iconData: Icons.local_restaurant),
    SearchPlace(searchWord: "コンビニ", placeType: "convenience_store", iconData: Icons.local_convenience_store),
    SearchPlace(searchWord: "スーパー", placeType: "store", iconData: Icons.local_grocery_store),
    SearchPlace(searchWord: "病院", placeType: "hospital", iconData: Icons.local_hospital),
    SearchPlace(searchWord: "薬局", placeType: "pharmacy", iconData: Icons.local_pharmacy),
    SearchPlace(searchWord: "ATM", placeType: "atm", iconData: Icons.local_atm),
    SearchPlace(searchWord: "銀行", placeType: "bank", iconData: Icons.monetization_on),
    SearchPlace(searchWord: "映画館", placeType: "movie_theater", iconData: Icons.local_movies),
    SearchPlace(searchWord: "図書館", placeType: "library", iconData: Icons.local_library),
    SearchPlace(searchWord: "JR乗り場", placeType: "train_station", iconData: Icons.train),
    SearchPlace(searchWord: "地下鉄乗り場", placeType: "subway_station", iconData: Icons.subway),
    SearchPlace(searchWord: "バス乗り場", placeType: "bus_station", iconData: Icons.directions_bus),
    SearchPlace(searchWord: "タクシー乗り場", placeType: "taxi_stand", iconData: Icons.local_taxi),
    SearchPlace(searchWord: "美容室", placeType: "beauty_salon", iconData: Icons.mood),
    SearchPlace(searchWord: "パーキング", placeType: "parking", iconData: Icons.local_parking),
  ];

  Future<PermissionStatus> initialize() async {
    WidgetsBinding.instance?.addObserver(this);
    await AppTrackingTransparency.requestTrackingAuthorization();
    return updateLocation();
  }

  Future<PermissionStatus> updateLocation() async {
    var permission = await locationService.hasPermission();
    switch (permission) {
      case PermissionStatus.denied:
      case PermissionStatus.deniedForever:
      case PermissionStatus.grantedLimited: {
        var permission = await locationService.requestPermission();
        if ([PermissionStatus.grantedLimited, PermissionStatus.granted].contains(permission)) {
          continue next;
        } else {
          myLocationData = null;
          notifyListeners();
          return PermissionStatus.deniedForever;
        }
      }
      next: case PermissionStatus.granted:
        await _updateLocation();
        return PermissionStatus.granted;
    }
  }

  Future<void> _updateLocation() async {
    myLocationData = await Geo.Geolocator.getCurrentPosition(desiredAccuracy: Geo.LocationAccuracy.high);
    notifyListeners();
  }

  void setSearchInputWord(String searchInputWord) {
    this.searchInputWord = searchInputWord;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    myLocationData = null;
    locationChangedListen?.cancel();
    locationChangedListen = null;
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateLocation();
    }
  }
}
