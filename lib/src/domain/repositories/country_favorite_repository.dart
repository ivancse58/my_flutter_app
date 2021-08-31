abstract class CountryFavoriteRepository {
  Future<bool> setAsFavorite(String? alpha2Code, String? alpha3Code);

  Future<bool> isFavorite(String? alpha2Code, String? alpha3Code);
}
