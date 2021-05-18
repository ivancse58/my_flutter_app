import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/country.dart';
import '../utils/app_messages.dart';
import '../utils/debug_logger.dart';

class APIService {
  final logger = DebugLogger();
  static const boxName = 'CountryData';
  static const empty = 'empty';
  static const baseUrl = 'restcountries.eu';
  static const path = 'rest/v2/all';
  static const _status_code_200 = 200;

  late Box _box;
  List countryList = [];

  // GET https://restcountries.eu/rest/v2/all
  Future<bool> fetchCountryWithCache() async {
    //await Future.delayed(Duration(seconds: 5));

    logger.log('fetchCountry');
    _box = await Hive.openBox(boxName);
    logger.log('open box');
    try {
      final response = await http.get(Uri.https(baseUrl, path));
      logger.log('statusCode = ${response.statusCode}');
      if (response.statusCode == _status_code_200) {
        final data = parseCountries(response.body);
        logger.log('Saving data into hive');

        await saveDataIntoHive(data);
      } else {
        throw Exception('Unable to load data!');
      }
    } catch (e) {
      logger.log(e);
      throw Exception('Unable to load data!');
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
    logger.log('updateData');
    try {
      final response = await http.get(Uri.https(baseUrl, path));
      if (response.statusCode == _status_code_200) {
        final data = parseCountries(response.body);
        logger.log('Saving data into hive');

        await saveDataIntoHive(data);
        showToast(AppMessages.updateSuccessMessage);
      } else {
        showToast(AppMessages.updateErrorMessage);
      }
    } catch (e) {
      showToast(AppMessages.updateErrorMessage);
    }
  }

  Future saveDataIntoHive(data) async {
    await _box.clear();
    for (var d in data) {
      _box.add(d);
    }
    logger.log('save data into hive done');
  }

  List<CountryModel> parseCountries(String responseBody) {
    logger.log("---------parseCountries---------");
    //print(responseBody);
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<CountryModel>((json) => $CountryFromJson(json)).toList();
  }
}
