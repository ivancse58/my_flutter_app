import 'package:my_flutter_app/src/core/usecase/usecase_without_param.dart';
import 'package:my_flutter_app/src/domain/repositories/country_repository.dart';
import 'package:my_flutter_app/src/models/country.dart';

class GetSavedCountriesUseCase implements UseCaseWithoutParam<List<CountryModel>, void> {
  final CountryRepository _countryRepository;

  GetSavedCountriesUseCase(this._countryRepository);

  @override
  Future<List<CountryModel>> call() {
    return _countryRepository.getSavedCountryList();
  }
}
