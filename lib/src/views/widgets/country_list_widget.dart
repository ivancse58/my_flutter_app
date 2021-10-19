import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/country_fav.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/providers/fav_country_provider.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import 'country_favorite_widget.dart';

class CountryListWidget extends StatelessWidget {
  static const _flagHeight = 250.0;

  final CountryModel _countryModel;
  final String _languages;
  final Function _navigateCountryScreen;
  final int _index;

  CountryListWidget(
    this._index,
    this._countryModel,
    this._languages,
    this._navigateCountryScreen,
  );

  final _logger = DebugLogger();

  @override
  Widget build(BuildContext context) {
    _logger.log("CountryListWidget");
    final favKey = FavKey(
      _countryModel.alpha2Code,
      _countryModel.alpha3Code,
    );
    final countryFavModel = CountryFavModel(
      _countryModel,
      favKey,
      _countryModel.alpha2Code.toString() + '-' + _countryModel.alpha3Code.toString(),
    );
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Provider.of<FavCountryProvider>(context, listen: false).updateFavModel(countryFavModel);
    });

    final language = sprintf(AppMessages.labelLanguages, [_languages]);

    return InkWell(
      onTap: () => _navigateCountryScreen(),
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
                    flex: 7,
                    child: Column(
                      children: [
                        _getContainer(
                          _countryModel.name,
                          Theme.of(context).textTheme.headline2,
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
                  Expanded(
                    flex: 3,
                    child: CountryFavoriteWidget(_index, favKey),
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
            child: SvgWidget(_countryModel.flag!, _flagHeight),
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
