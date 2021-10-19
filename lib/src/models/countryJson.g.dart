// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel $CountryFromJson(Map<String, dynamic> json) {
  Map<String, dynamic> name = json['name'] as Map<String, dynamic>;
  Map<String, dynamic> flags = json['flags'] as Map<String, dynamic>;
  Map<String, dynamic>? currencies = json['currencies'] as Map<String, dynamic>?;
  Map<String, dynamic>? languages = json['languages'] as Map<String, dynamic>?;
  List<CurrencyModel> currencyList = [];
  if (currencies != null)
    for (var entry in currencies.entries) {
      var cm = CurrencyModel(
        entry.key,
        entry.value['name'] as String?,
        entry.value['symbol'] as String?,
      );
      currencyList.add(cm);
    }

  List<LanguageModel> languageList = [];
  if (languages != null)
    for (var entry in languages.entries) {
      var lm = LanguageModel(
        entry.value as String?,
        entry.key,
      );
      languageList.add(lm);
    }
  return CountryModel(
    name['common'] as String,
    json['cca2'] as String?,
    json['cca3'] as String?,
    flags['svg'] as String?,
    json['isFav'] as bool?,
    currencyList,
    languageList,
  );
}
