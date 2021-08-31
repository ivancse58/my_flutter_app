// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CountryApiService implements CountryApiService {
  _CountryApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://restcountries.eu';
  }

  final Dio _dio;
  String? baseUrl;

  @override
  Future<HttpResponse<List<CountryModel>?>> getCountryList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<CountryModel>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/rest/v2/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    List<CountryModel> items = [];
    (_result.data as List<dynamic>).forEach((element) =>
        items.add($CountryFromJson(element as Map<String, dynamic>)));
    final httpResponse = HttpResponse(items, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
