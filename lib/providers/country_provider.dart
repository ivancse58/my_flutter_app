import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryProvider with ChangeNotifier {
  CountryModel? item;
  String? lanStr;
  String? callingCodeStr;

  void setCountry(CountryModel value, String lanStr, String callingCodeStr) {
    this.lanStr = lanStr;
    this.callingCodeStr = callingCodeStr;
    this.item = value;
    //notifyListeners();
  }
}
