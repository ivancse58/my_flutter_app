//@JsonSerializable()
class LanguageResponse {
  String? name;
  String? iso639_1;
  String? iso639_2;
  String? nativeName;

  LanguageResponse(
    this.name,
    this.iso639_1,
    this.iso639_2,
    this.nativeName,
  );
}

//@JsonSerializable()
class Currency {
  String? code;
  String? name;
  String? symbol;

  Currency(
    this.code,
    this.name,
    this.symbol,
  );
}

//@JsonSerializable()
class Country {
  String? name;
  String? alpha2Code;
  String? alpha3Code;
  String? flag;
  bool? isFav;
  List<Currency>? currencies;
  List<LanguageResponse>? languages;
  List<String>? callingCodes;

  Country(
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
