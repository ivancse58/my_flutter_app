import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';

class APIService {
  static const boxName = 'CountryData';
  static const empty = 'empty';

  late Box _box;
  List countryList = [];

  // GET https://restcountries.eu/rest/v2/all
  Future<bool> fetchCountryWithCache() async {
    //await Future.delayed(Duration(seconds: 5));

    print('fetchCountry');
    _box = await Hive.openBox(boxName);
    print('open box');
    try {
      final response =
          await http.get(Uri.https('restcountries.eu', 'rest/v2/all'));
      print('statusCode = ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = parseCountries(response.body);
        print('Saving data into hive');

        await saveDataIntoHive(data);
      } else {
        throw Exception('Unable to load data!');
      }
    } catch (e) {
      print('Unable to load data!');
    }

    var myMap = _box.toMap().values.toList();
    if (myMap.isEmpty) {
      countryList.add(empty);
    } else {
      countryList = myMap;
    }

    return Future.value(true);
  }

  Future<void> updateData(Function showToast, Function updateState) async {
    print('updateData');
    try {
      final response =
          await http.get(Uri.https('restcountries.eu', 'rest/v2/all'));
      if (response.statusCode == 200) {
        final data = parseCountries(response.body);
        print('Saving data into hive');

        await saveDataIntoHive(data);
      } else {
        showToast();
      }
    } catch (e) {
      showToast();
    }
  }

  Future saveDataIntoHive(data) async {
    await _box.clear();
    for (var d in data) {
      _box.add(d);
    }
    print('save data into hive done');
  }
}

List<CountryModel> parseCountries(String responseBody) {
  print("---------parseCountries---------");
  //print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CountryModel>((json) => $CountryFromJson(json)).toList();
}
