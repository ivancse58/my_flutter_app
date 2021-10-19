import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:retrofit/retrofit.dart';

part 'country_api_service.g.dart';

@RestApi(baseUrl: 'https://restcountries.com')
abstract class CountryApiService {
  factory CountryApiService(Dio dio, Alice alice, {String baseUrl}) = _CountryApiService;

  @GET('/v3.1/all')
  Future<HttpResponse<List<CountryModel>?>> getCountryList();
}
