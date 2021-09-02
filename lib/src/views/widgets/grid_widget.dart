import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/providers/country_provider.dart';
import 'package:my_flutter_app/src/views/widgets/country_grid_widget.dart';
import 'package:my_flutter_app/src/views/widgets/country_list_widget.dart';
import 'package:provider/provider.dart';

import '../screens/country_screen.dart';
import 'data_tab_widget.dart';

class GridWidget extends StatefulWidget {
  final List<CountryModel> countryList;

  GridWidget(this.countryList);

  GridViewState createState() => GridViewState(countryList);
}

class GridViewState extends State<GridWidget> {
  final List<CountryModel> countryList;
  bool _isGrid = false;
  double _childAspectRatio = 0.95;

  GridViewState(this.countryList);

  void _changeMode() {
    if (_isGrid) {
      setState(() {
        _isGrid = false;
        _childAspectRatio = 0.95;
      });
    } else {
      setState(() {
        _isGrid = true;
        _childAspectRatio = 0.75;
      });
    }
  }

  final _selectedBtnStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    primary: Colors.blue,
    side: BorderSide(width: 1.0, color: Colors.green),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  final _buttonStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    side: BorderSide(width: 1.0, color: Colors.black26),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  ButtonStyle? _getSelectedBtnStyle(bool isSelected) {
    return isSelected ? _selectedBtnStyle : _buttonStyle;
  }

  Color _getSelectedColor(bool isSelected) {
    return isSelected ? Colors.white : Colors.black26;
  }

  @override
  Widget build(BuildContext context) {
    final gridView = GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      children: countryList.map((data) {
        return CountryGridWidget(
          data,
          _getLanguage(data),
          () => {_navigateCountryScreen(context, data)},
        );
      }).toList(),
    );
    final listView = GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 0.95,
      children: countryList.map((data) {
        return CountryListWidget(
          data,
          _getLanguage(data),
          () => {_navigateCountryScreen(context, data)},
        );
      }).toList(),
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: DataTabWidget(listView, gridView)),
        ],
      ),
    );
  }

  void _navigateCountryScreen(BuildContext ctx, CountryModel item) {
    Provider.of<CountryProvider>(ctx, listen: false)
        .setCountry(item, _getLanguage);

    Navigator.of(ctx).pushNamed(CountryScreen.routeName);
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
}
