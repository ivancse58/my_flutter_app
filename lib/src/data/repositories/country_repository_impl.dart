import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/data/services/country_api_service.dart';
import 'package:my_flutter_app/src/domain/repositories/country_repository.dart';
import 'package:my_flutter_app/src/models/country.dart';

class CountryRepositoryImpl extends CountryRepository {
  static const boxName = 'CountryData';
  static const favBoxName = 'CountryFavorite';
  final CountryApiService _countryApiService;
  final _logger = DebugLogger();

  late Box _box;

  CountryRepositoryImpl(this._countryApiService);

  @override
  Future<DataState<List<CountryModel>>> getCountryList() async {
    _logger.log('CountryRepositoryImpl getCountryList');
    _box = await Hive.openBox(boxName);
    try {
      final httpResponse = await _countryApiService.getCountryList();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final data = httpResponse.data;
        if (data == null) {
          return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions,
          ));
        } else {
          await _saveDataIntoHive(data);
          return DataSuccess(data);
        }
      }
      _logger.log('CountryRepositoryImpl DataFailed');
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioError catch (e) {
      _logger.log('CountryRepositoryImpl DataFailed');
      return DataFailed(e);
    }
  }

  @override
  Future<List<CountryModel>> getSavedCountryList() async {
    _logger.log('CountryRepositoryImpl getSavedCountryList');
    _box = await Hive.openBox(boxName);
    return _box.values.map((country) => country as CountryModel).toList();
  }

  Future _saveDataIntoHive(data) async {
    await _box.clear();
    for (var d in data) {
      _box.add(d);
    }
    _logger.log('CountryRepositoryImpl _saveDataIntoHive done');
  }
}
