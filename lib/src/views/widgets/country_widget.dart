import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/app_messages.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:sprintf/sprintf.dart';

import 'country_favorite_widget.dart';

class CountryWidget extends StatefulWidget {
  static const _flagHeight = 250.0;

  final CountryModel _countryModel;
  final String _languages;
  final Function _navigateCountryScreen;

  CountryWidget(
    this._countryModel,
    this._languages,
    this._navigateCountryScreen,
  );

  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  final _logger = DebugLogger();

  @override
  Widget build(BuildContext context) {
    final callingCode = sprintf(AppMessages.label_calling_codes,
        [widget._countryModel.callingCodes!.first.toString()]);
    final language = sprintf(AppMessages.label_languages, [widget._languages]);
    final favKey = FavKey(
        widget._countryModel.alpha2Code, widget._countryModel.alpha3Code);

    _logger.log('_CountryWidgetState data loaded!!');
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
                    child: SvgWidget(
                        widget._countryModel.flag!, CountryWidget._flagHeight),
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
                        CountryFavoriteWidget(favKey),
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
}
