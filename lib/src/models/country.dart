//@JsonSerializable()


import 'package:hive/hive.dart';

part 'countryHive.g.dart';
part 'countryJson.g.dart';

@HiveType(typeId: 2)
class LanguageModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? code;

  LanguageModel(
    this.name,
    this.code,
  );
}

//@JsonSerializable()
@HiveType(typeId: 1)
class CurrencyModel {
  @HiveField(0)
  String? code;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? symbol;

  CurrencyModel(
    this.code,
    this.name,
    this.symbol,
  );
}

//@JsonSerializable()
@HiveType(typeId: 0)
class CountryModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? alpha2Code;

  @HiveField(2)
  String? alpha3Code;

  @HiveField(3)
  String? flag;

  @HiveField(4)
  bool? isFav;

  @HiveField(5)
  List<CurrencyModel>? currencies;

  @HiveField(6)
  List<LanguageModel>? languages;

  CountryModel(
    this.name,
    this.alpha2Code,
    this.alpha3Code,
    this.flag,
    this.isFav,
    this.currencies,
    this.languages,
  );
}
