import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';

class CountryFavProvider with ChangeNotifier {
  FavKey? favKey;
  bool isFavorite = false;

  void setInitFavoriteStatus(FavKey favKey, bool isFav) {
    this.favKey = favKey;
    this.isFavorite = isFav;
  }

  void toggleFavoriteStatus(bool isFav) {
    isFavorite = isFav;
    notifyListeners();
  }
}
