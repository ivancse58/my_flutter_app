import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/usecase/get_countries_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/get_saved_countries_usecase.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/providers/country_provider.dart';
import 'package:my_flutter_app/src/views/widgets/country_list_widget.dart';
import 'package:provider/provider.dart';

import '../../injector.dart';
import 'country_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = -1;
  final _logger = DebugLogger();
  bool dataReloaded = false;

  final GetCountryUseCase _getCountryUseCase = injector<GetCountryUseCase>();
  final GetSavedCountriesUseCase _getSavedCountriesUseCase = injector<GetSavedCountriesUseCase>();
  final AppBar _appBar = AppBar(
    title: Text(AppMessages.appName),
  );

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
                  return _buildEmptyWidget(AppMessages.errorMessage);
                else
                  return _displayDataView(snapshot.data as List<CountryModel>);
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(String errorMessage) {
    _logger.log(errorMessage);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          icon: Icon(Icons.replay, color: Colors.red),
          label: Text(
            errorMessage,
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: () => setState(() {}),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            side: BorderSide(width: 2.0, color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayDataView(List<CountryModel> countryList) {
    if (countryList.isEmpty) {
      return _buildEmptyWidget(AppMessages.emptyMessage);
    } else {
      return RefreshIndicator(
        onRefresh: () => _getLatestCountries(),
        child: ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, index) {
            final data = countryList[index];
            return CountryListWidget(
              data,
              _getLanguage(data),
              () => {_navigateCountryScreen(context, data, index)},
            );
          },
        ),
      );
    }
  }

  String _getLanguage(CountryModel item) {
    var languages = StringBuffer();
    final items = item.languages!.map((e) => e.name).toList();
    for (int i = 0; i < items.length; i++) {
      languages.write(items[i]);
      if (i + 1 < items.length) languages.write(', ');
    }
    return languages.toString();
  }

  void _navigateCountryScreen(BuildContext ctx, CountryModel item, int index) {
    Provider.of<CountryProvider>(ctx, listen: false).setCountry(item, _getLanguage);
    Navigator.of(ctx).pushNamed(CountryScreen.routeName);
  }

  void _showUpdateNotification(String value) {
    final snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _getLatestCountries() async {
    final dataState = await _getCountryUseCase.call();
    if (dataState is DataSuccess) {
      setState(() {
        _logger.log("Data reloaded!");
      });
      _showUpdateNotification(AppMessages.updateSuccessMessage);
    }
    if (dataState is DataFailed) {
      _showUpdateNotification(AppMessages.updateErrorMessage);
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
        throw Exception(AppMessages.errorMessage);
      }
    }
    return cacheItems;
  }
}
