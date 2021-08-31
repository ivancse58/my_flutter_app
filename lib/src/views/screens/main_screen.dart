import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/domain/usecase/get_countries_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/get_saved_countries_usecase.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/utils/app_messages.dart';
import 'package:my_flutter_app/src/utils/debug_logger.dart';
import 'package:my_flutter_app/src/views/widgets/country_widget.dart';

import '../../injector.dart';

class MainScreen extends StatefulWidget {
  //final Alice alice;

  @override
  _MainScreenState createState() => _MainScreenState(
        injector<GetCountryUseCase>(),
        injector<GetSavedCountriesUseCase>(),
      );
}

class _MainScreenState extends State<MainScreen> {
  final logger = DebugLogger();
  final GetCountryUseCase _getCountryUseCase;
  final GetSavedCountriesUseCase _getSavedCountriesUseCase;
  final AppBar _appBar = AppBar(
    title: Text('Fetch All Countries'),
  );

  _MainScreenState(this._getCountryUseCase, this._getSavedCountriesUseCase);

  Widget buildEmptyWidget(String errorMessage) {
    logger.log(errorMessage);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            Icon(Icons.replay),
          ],
        ),
      ),
      onTap: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: FutureBuilder(
          future: _getCountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return buildEmptyWidget(AppMessages.errorMessage);
                else {
                  List countryList = snapshot.data as List<CountryModel>;
                  if (countryList.isEmpty) {
                    return buildEmptyWidget(AppMessages.emptyMessage);
                  } else
                    return RefreshIndicator(
                      onRefresh: () => _getLatestCountries((value) {
                        final snackBar = SnackBar(content: Text(value));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }, setState),
                      child: ListView.builder(
                        // Let the ListView know how many items it needs to build.
                        itemCount: countryList.length,
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (context, index) {
                          final item = countryList[index];
                          return CountryWidget(item);
                        },
                      ),
                    );
                }
            }
          },
        ),
      ),
    );
  }

  Future<List<CountryModel>?> _getLatestCountries(
      Function showToast, Function updateState) async {
    final dataState = await _getCountryUseCase.call();
    if (dataState is DataSuccess) {
      showToast(AppMessages.updateSuccessMessage);
      return dataState.data;
    }
    if (dataState is DataFailed) {
      showToast(AppMessages.updateErrorMessage);
    }
  }

  Future<List<CountryModel>?> _getCountries() async {
    final cacheItems = await _getSavedCountriesUseCase.call();
    if (cacheItems.isEmpty) {
      final dataState = await _getCountryUseCase.call();
      if (dataState is DataSuccess) {
        return dataState.data;
      }
      if (dataState is DataFailed) {
        throw Exception('Unable to load data!');
      }
    }
    return cacheItems;
  }
}
