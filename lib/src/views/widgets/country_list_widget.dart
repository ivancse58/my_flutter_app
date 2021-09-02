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
  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);
  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();

  @override
  Widget build(BuildContext context) {
    _logger.log("CountryListWidget");
    final favKey = FavKey(
      widget._countryModel.alpha2Code,
      widget._countryModel.alpha3Code,
    );
    // this is creating loop!
    _getFav(favKey);

    final callingCode = sprintf(AppMessages.labelCallingCodes,
        [widget._countryModel.callingCodes!.first.toString()]);
    final language = sprintf(AppMessages.labelLanguages, [widget._languages]);

    return InkWell(
      onTap: () => widget._navigateCountryScreen(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: SvgWidget(widget._countryModel.flag!,
                        CountryListWidget._flagHeight),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget._countryModel.name!,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        callingCode,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          language,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        ValueListenableBuilder<bool>(
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

  void _updateFavState(bool isFav) {
    _logger.log('CountryListWidget _updateFavState $isFav');
    if (mounted)
      setState(() {
        _isFav.value = isFav;
      });
  }

  void _getFav(FavKey favKey) {
    _getFavCountry.call(params: favKey).then(
          (val) => {_updateFavState(val)},
        );
  }
}
