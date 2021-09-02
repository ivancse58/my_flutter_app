import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:sprintf/sprintf.dart';

class CountryListWidget extends StatefulWidget {
  static const _flagHeight = 250.0;

  final CountryModel _countryModel;
  final String _languages;
  final Function _navigateCountryScreen;

  CountryListWidget(
    this._countryModel,
    this._languages,
    this._navigateCountryScreen,
  );

  @override
  _CountryListWidgetState createState() => _CountryListWidgetState();
}

class _CountryListWidgetState extends State<CountryListWidget> {
  final _logger = DebugLogger();

  @override
  Widget build(BuildContext context) {
    _logger.log("CountryListWidget");
    final favKey = FavKey(
      widget._countryModel.alpha2Code,
      widget._countryModel.alpha3Code,
    );
    // this is creating loop!
    //_getFav(favKey);

    final callingCode = sprintf(
        AppMessages.labelCallingCodes, [widget._countryModel.callingCodes!.first.toString()]);
    final language = sprintf(AppMessages.labelLanguages, [widget._languages]);

    return InkWell(
      onTap: () => widget._navigateCountryScreen(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            _getFlagView(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _getContainer(
                          widget._countryModel.name,
                          Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 8),
                        _getContainer(
                          callingCode,
                          Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        _getContainer(
                          language,
                          Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFlagView() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: SvgWidget(widget._countryModel.flag!, CountryListWidget._flagHeight),
          ),
        ],
      ),
    );
  }

  Widget _getContainer(String? text, TextStyle? textStyle) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        text!,
        style: textStyle,
      ),
    );
  }
}
