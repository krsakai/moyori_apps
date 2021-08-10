class PlaceListPageArguments {
  const PlaceListPageArguments({
    required this.lat,
    required this.lon,
    required this.searchWord,
    this.placeType
  });

  final double lat;
  final double lon;
  final String searchWord;
  final String? placeType;
}