import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/data/datasources/service/country_api_service.dart';
import 'package:my_flutter_app/src/domain/repositories/country_repository.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/utils/debug_logger.dart';

class CountryRepositoryImpl extends CountryRepository {
  static const boxName = 'CountryData';
  final CountryApiService _countryApiService;
  final _logger = DebugLogger();

  late Box _box;

  CountryRepositoryImpl(this._countryApiService);

  @override
  Future<DataState<List<CountryModel>>> getCountryList() async {
    _logger.log('CountryRepositoryImpl getCountryList');
    _box = await Hive.openBox(boxName);
    try {
      _logger.log('CountryRepositoryImpl try1');
      final httpResponse = await _countryApiService.getCountryList();
      _logger.log('CountryRepositoryImpl api getCountryList');

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
    _box = await Hive.openBox(boxName);
    return _box.values.map((country) => country as CountryModel).toList();
  }

  Future _saveDataIntoHive(data) async {
    await _box.clear();
    for (var d in data) {
      _box.add(d);
    }
    _logger.log('save data into hive done');
  }
}
