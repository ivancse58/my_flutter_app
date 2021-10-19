import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:sprintf/sprintf.dart';

class CountryProvider with ChangeNotifier {
  CountryModel? item;
  String? lanStr;
  String? language;
  FavKey? favKey;

  void setCountry(CountryModel value, Function(CountryModel) getLanguage) {
    this.item = value;
    favKey = FavKey(value.alpha2Code, value.alpha3Code);
    this.lanStr = getLanguage(value);
    this.language = sprintf(AppMessages.labelLanguages, [this.lanStr]);
    //notifyListeners();
  }
}
