import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/core/usecase/usecase_without_param.dart';
import 'package:my_flutter_app/src/domain/repositories/country_repository.dart';
import 'package:my_flutter_app/src/models/country.dart';

class GetCountryUseCase implements UseCaseWithoutParam<DataState<List<CountryModel>>, Object> {
  final CountryRepository _countryRepository;

  GetCountryUseCase(this._countryRepository);

  @override
  Future<DataState<List<CountryModel>>> call() {
    return _countryRepository.getCountryList();
  }
}
