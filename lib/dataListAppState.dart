import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'country.dart';
import 'item_card.dart';
import 'main.dart';

class DataListAppState extends State<MyApp> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch All Countries'),
        ),
        body: Center(
          child: FutureBuilder<List<Country>>(
            future: futureCountries,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: snapshot.data?.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return CountryWidget(item);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

List<Country> parseCountries(String responseBody) {
  print("---------parseCountries---------");
  //print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Country>((json) => _$CountryFromJson(json)).toList();
}

// GET https://restcountries.eu/rest/v2/all
Future<List<Country>> fetchCountry() async {
  final response = await http.get(Uri.https('restcountries.eu', 'rest/v2/all'));
  //print(response.statusCode);
  if (response.statusCode == 200) {
    return parseCountries(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageResponse _$LanguageResponseFromJson(Map<String, dynamic> json) {
  return LanguageResponse(
    json['name'] as String?,
    json['iso639_1'] as String?,
    json['iso639_2'] as String?,
    json['nativeName'] as String?,
  );
}

Map<String, dynamic> _$LanguageResponseToJson(LanguageResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iso639_1': instance.iso639_1,
      'iso639_2': instance.iso639_2,
      'nativeName': instance.nativeName,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    json['code'] as String?,
    json['name'] as String?,
    json['symbol'] as String?,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
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

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'alpha2Code': instance.alpha2Code,
      'alpha3Code': instance.alpha3Code,
      'flag': instance.flag,
      'isFav': instance.isFav,
      'currencies': instance.currencies,
      'languages': instance.languages,
    };
