import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/models/country.dart';

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
