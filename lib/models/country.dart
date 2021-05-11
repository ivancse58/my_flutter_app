//@JsonSerializable()
class LanguageModel {
  String? name;
  String? iso639_1;
  String? iso639_2;
  String? nativeName;

  LanguageModel(
    this.name,
    this.iso639_1,
    this.iso639_2,
    this.nativeName,
  );
}

//@JsonSerializable()
class CurrencyModel {
  String? code;
  String? name;
  String? symbol;

  CurrencyModel(
    this.code,
    this.name,
    this.symbol,
  );
}

//@JsonSerializable()
class CountryModel {
  String? name;
  String? alpha2Code;
  String? alpha3Code;
  String? flag;
  bool? isFav;
  List<CurrencyModel>? currencies;
  List<LanguageModel>? languages;
  List<String>? callingCodes;

  CountryModel(
    this.name,
    this.alpha2Code,
    this.alpha3Code,
    this.flag,
    this.isFav,
    this.currencies,
    this.languages,
    this.callingCodes,
  );
}
