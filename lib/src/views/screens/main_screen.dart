import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/resources/data_state.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_countries_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/get_saved_countries_usecase.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/providers/country_provider.dart';
import 'package:my_flutter_app/src/views/providers/fav_remove_provider.dart';
import 'package:my_flutter_app/src/views/widgets/country_list_widget.dart';
import 'package:provider/provider.dart';

import '../../injector.dart';
import 'country_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _logger = DebugLogger();
  final GetCountryUseCase _getCountryUseCase = injector<GetCountryUseCase>();
  final GetSavedCountriesUseCase _getSavedCountriesUseCase = injector<GetSavedCountriesUseCase>();
  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Center(
        child: FutureBuilder(
          future: _getCountries(_showOnlyFavorites),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return _buildEmptyWidget(snapshot.error.toString());
                else
                  return _displayDataView(snapshot.data as List<CountryModel>);
            }
          },
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text(AppMessages.appName),
      actions: <Widget>[
        _getMenu(),
      ],
    );
  }

  Widget _getMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.Favorites) {
            _showOnlyFavorites = true;
          } else {
            _showOnlyFavorites = false;
          }
        });
      },
      icon: Icon(
        Icons.more_vert,
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Only Favorites'),
          value: FilterOptions.Favorites,
        ),
        PopupMenuItem(
          child: Text('Show All'),
          value: FilterOptions.All,
        ),
      ],
    );
  }

  Widget _buildEmptyWidget(String errorMessage) {
    _logger.log("_buildEmptyWidget $errorMessage");
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
      return _buildEmptyWidget(
          _showOnlyFavorites ? AppMessages.favErrorMessage : AppMessages.emptyMessage);
    } else {
      return RefreshIndicator(
        onRefresh: () => _getLatestCountries(),
        child: Consumer<FavRemoveProvider>(
          builder: (context, favRemoveProvider, child) =>
              _getListView(countryList, favRemoveProvider.index),
        ),
      );
    }
  }

  Widget _getListView(List<CountryModel> countryList, int index) {
    if (index >= 0) countryList.removeAt(index);
    if (countryList.isEmpty) return _buildEmptyWidget(AppMessages.favErrorMessage);

    return ListView.builder(
      key: UniqueKey(),
      shrinkWrap: true,
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        final data = countryList[index];
        return CountryListWidget(
          index,
          data,
          _getLanguage(data),
          () => {_navigateCountryScreen(context, data, index)},
        );
      },
    );
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

  Future<List<CountryModel>?> _getCountries(bool onlyFavorites) async {
    _logger.log("_getCountries enter $onlyFavorites");
    final cacheItems = await _getSavedCountriesUseCase.call();
    if (cacheItems.isEmpty) {
      final dataState = await _getCountryUseCase.call();
      if (dataState is DataSuccess) {
        if (onlyFavorites) {
          _logger.log("_getCountries onlyFavorites without cache $onlyFavorites");
          return _getFavItems(dataState.data);
        } else
          return dataState.data;
      }
      if (dataState is DataFailed) {
        throw Exception(AppMessages.errorMessage);
      }
    }
    if (onlyFavorites) {
      _logger.log("_getCountries onlyFavorites with cache $onlyFavorites");
      return _getFavItems(cacheItems.toList());
    }

    return cacheItems;
  }

  Future<List<CountryModel>?> _getFavItems(List<CountryModel?>? data) {
    List<CountryModel> favList = [];
    if (data != null)
      for (CountryModel? country in data) {
        if (country != null) {
          _getFavCountry.call(params: FavKey(country.alpha2Code, country.alpha3Code)).then(
                (val) => {if (val) favList.add(country)},
              );
        }
      }
    return Future<List<CountryModel>>.value(favList);
  }
}
