// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageResponseFromJson(Map<String, dynamic> json) {
  return LanguageModel(
    json['name'] as String?,
    json['iso639_1'] as String?,
    json['iso639_2'] as String?,
    json['nativeName'] as String?,
  );
}

Map<String, dynamic> _$LanguageResponseToJson(LanguageModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iso639_1': instance.iso639_1,
      'iso639_2': instance.iso639_2,
      'nativeName': instance.nativeName,
    };

CurrencyModel _$CurrencyFromJson(Map<String, dynamic> json) {
  return CurrencyModel(
    json['code'] as String?,
    json['name'] as String?,
    json['symbol'] as String?,
  );
}

Map<String, dynamic> _$CurrencyToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };

CountryModel $CountryFromJson(Map<String, dynamic> json) {
  return CountryModel(
    json['name'] as String?,
    json['alpha2Code'] as String?,
    json['alpha3Code'] as String?,
    json['flag'] as String?,
    json['isFav'] as bool?,
    (json['currencies'] as List<dynamic>)
        .map((currency) => _$CurrencyFromJson(currency as Map<String, dynamic>))
        .toList(),
    (json['languages'] as List<dynamic>)
        .map((language) =>
            _$LanguageResponseFromJson(language as Map<String, dynamic>))
        .toList(),
    (json['callingCodes'] as List<dynamic>)
        .map((callingCode) => callingCode as String)
        .toList(),
  );
}

Map<String, dynamic> _$CountryToJson(CountryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'alpha2Code': instance.alpha2Code,
      'alpha3Code': instance.alpha3Code,
      'flag': instance.flag,
      'isFav': instance.isFav,
      'currencies': instance.currencies,
      'languages': instance.languages,
    };