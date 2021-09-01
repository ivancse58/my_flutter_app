import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/widgets/country_grid_widget.dart';
import 'package:my_flutter_app/src/views/widgets/country_widget.dart';

class GridWidget extends StatefulWidget {
  final List<CountryModel> countryList;

  GridWidget(this.countryList);

  GridViewState createState() => GridViewState(countryList);
}

class GridViewState extends State {
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
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    icon: Icon(
                      Icons.view_list,
                      color: _getSelectedColor(!_isGrid),
                    ),
                    label: Text(
                      "List View",
                      style: TextStyle(color: _getSelectedColor(!_isGrid)),
                    ),
                    onPressed: () => _changeMode(),
                    style: _getSelectedBtnStyle(!_isGrid),
                  ),
                  SizedBox(width: 4),
                  OutlinedButton.icon(
                    icon: Icon(
                      Icons.grid_4x4,
                      color: _getSelectedColor(_isGrid),
                    ),
                    label: Text(
                      "Grid View",
                      style: TextStyle(color: _getSelectedColor(_isGrid)),
                    ),
                    onPressed: () => _changeMode(),
                    style: _getSelectedBtnStyle(_isGrid),
                  )
                ],
              )),
          Expanded(
            child: GridView.count(
              crossAxisCount: _isGrid ? 2 : 1,
              childAspectRatio: _childAspectRatio,
              children: countryList.map((data) {
                return _isGrid
                    ? CountryGridWidget(data, _getLanguage)
                    : CountryWidget(data, _getLanguage);
              }).toList(),
            ),
          ),
        ],
      ),
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
}
