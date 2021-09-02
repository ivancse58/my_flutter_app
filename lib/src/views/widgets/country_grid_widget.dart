import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:sprintf/sprintf.dart';

import '../../injector.dart';
import 'country_favorite_widget.dart';

class CountryGridWidget extends StatefulWidget {
  static const _flagHeight = 100.0;

  final CountryModel _countryModel;
  final String _languages;
  final Function _navigateCountryScreen;

  CountryGridWidget(
    this._countryModel,
    this._languages,
    this._navigateCountryScreen,
  );

  @override
  _CountryGridWidgetState createState() => _CountryGridWidgetState();
}

class _CountryGridWidgetState extends State<CountryGridWidget> {
  final _logger = DebugLogger();
  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);
  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();

  @override
  Widget build(BuildContext context) {
    final favKey = FavKey(
      widget._countryModel.alpha2Code,
      widget._countryModel.alpha3Code,
    );
    final callingCode = sprintf(AppMessages.labelCallingCodes,
        [widget._countryModel.callingCodes!.first.toString()]);
    final language = sprintf(AppMessages.labelLanguages, [widget._languages]);

    // this is creating loop!
    _getFav(favKey);

    return InkWell(
      onTap: () => widget._navigateCountryScreen(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            _getFlagView(),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        _getContainer(
                          widget._countryModel.name,
                          Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(width: 4),
                        _getContainer(
                          callingCode,
                          Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(width: 4),
                        _getContainer(
                          language,
                          Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ValueListenableBuilder<bool>(
                      builder: (
                        BuildContext context,
                        bool value,
                        Widget? child,
                      ) {
                        return CountryFavoriteWidget(
                          value,
                          favKey,
                          _updateFavState,
                        );
                      },
                      valueListenable: _isFav,
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

  void _updateFavState(bool isFav) {
    _logger.log('CountryGrid _updateFavState $isFav');
    if (mounted)
      setState(() {
        _isFav.value = isFav;
      });
  }

  Widget _getFlagView() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: SvgWidget(
                widget._countryModel.flag!, CountryGridWidget._flagHeight),
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

  void _getFav(FavKey favKey) {
    _getFavCountry.call(params: favKey).then(
          (val) => {_updateFavState(val)},
        );
  }
}
