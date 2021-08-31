import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/models/country.dart';

abstract class CountryRepository {
  // API methods
  Future<DataState<List<CountryModel>>> getCountryList();

  // Database methods
  Future<List<CountryModel>> getSavedCountryList();
}
