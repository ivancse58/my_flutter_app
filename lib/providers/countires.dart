import 'package:flutter/material.dart';

import '../models/country.dart';

class Countries with ChangeNotifier {
  CountryModel? item;

  void setCountry(CountryModel value) {
    item = value;
    notifyListeners();
  }
}
