import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';

class CountryFavModel {
  final FavKey favKey;
  final String key;
  final CountryModel countryModel;
  bool isFav = false;

  CountryFavModel(this.countryModel, this.favKey, this.key, [this.isFav = false]);
}
