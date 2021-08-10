import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class SearchInformation {
  String get searchWord;
}

@immutable
class SearchPlace implements SearchInformation {
  const SearchPlace({
    required this.searchWord,
    required this.placeType,
    required this.iconData,
  });

  final String searchWord;
  final String placeType;
  final IconData iconData;
}