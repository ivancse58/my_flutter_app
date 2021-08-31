import 'package:dio/dio.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/utils/debug_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'country_api_service.g.dart';

@RestApi(baseUrl: 'https://restcountries.eu')
abstract class CountryApiService {
  factory CountryApiService(Dio dio, {String baseUrl}) = _CountryApiService;

  @GET('/rest/v2/all')
  Future<HttpResponse<List<CountryModel>?>> getCountryList();
}
