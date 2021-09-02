import 'package:hive/hive.dart';
import 'package:my_flutter_app/src/domain/repositories/country_favorite_repository.dart';

class CountryFavoriteRepositoryImpl extends CountryFavoriteRepository {
  static const boxName = 'CountryFavorite';
  late Box _box;

  @override
  Future<bool> isFavorite(String? alpha2Code, String? alpha3Code) async {
    _box = await Hive.openBox(boxName);
    var key = alpha2Code.toString() + '-' + alpha3Code.toString();
    final bool? value = (_box).get(key) as bool?;
    var val = value != null ? value : false;
    return Future<bool>.value(val);
  }

  @override
  Future<bool> setAsFavorite(String? alpha2Code, String? alpha3Code) async {
    _box = await Hive.openBox(boxName);
    var val = await isFavorite(alpha2Code, alpha3Code);
    var key = alpha2Code.toString() + '-' + alpha3Code.toString();

    _box.put(key, !val);
    return Future<bool>.value(!val);
  }
}
