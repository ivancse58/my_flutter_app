import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/country_fav.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';

class FavCountryProvider with ChangeNotifier {
  Map<String, CountryFavModel> _countryFavList = Map<String, CountryFavModel>();

  void updateFavModel(CountryFavModel value) {
    _countryFavList.addAll({value.key: value});
    notifyListeners();
  }

  CountryFavModel? getFavModel(FavKey favKey) {
    final key = favKey.alpha2Code.toString() + '-' + favKey.alpha3Code.toString();
    return this._countryFavList[key];
  }
}
