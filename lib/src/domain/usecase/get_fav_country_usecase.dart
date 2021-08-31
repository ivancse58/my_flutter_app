import 'package:my_flutter_app/src/core/usecase/usecase.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/repositories/country_favorite_repository.dart';

class GetFavCountryUseCase implements UseCase<bool, FavKey> {
  final CountryFavoriteRepository _countryFavoriteRepository;

  GetFavCountryUseCase(this._countryFavoriteRepository);

  @override
  Future<bool> call({required FavKey params}) {
    return _countryFavoriteRepository.isFavorite(
      params.alpha2Code,
      params.alpha3Code,
    );
  }
}
