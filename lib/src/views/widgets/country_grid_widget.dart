import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/models/country.dart';
import 'package:my_flutter_app/src/utils/app_messages.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import '../providers/country_provider.dart';
import '../screens/country_screen.dart';
import 'country_favorite_widget.dart';

class CountryGridWidget extends StatelessWidget {
  static const _flagHeight = 100.0;

  final CountryModel item;
  final Function(CountryModel) getLanguage;

  CountryGridWidget(this.item, this.getLanguage);

  void selectCountry(BuildContext ctx, String lanStr, String callingCodeStr) {
    Provider.of<CountryProvider>(ctx, listen: false)
        .setCountry(item, lanStr, callingCodeStr);
    Navigator.of(ctx).pushNamed(CountryScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final callingCodes = item.callingCodes!.first.toString();
    final languages = getLanguage(item);
    final callingCode =
        sprintf(AppMessages.label_calling_codes, [callingCodes]);
    final language = sprintf(AppMessages.label_languages, [languages]);

    return InkWell(
      onTap: () => selectCountry(context, languages, callingCodes),
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
                          item.name,
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
                    child: CountryFavoriteWidget(
                      FavKey(item.alpha2Code, item.alpha3Code),
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
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: SvgPicture.network(
              item.flag!,
              height: _flagHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext ctx) => Container(
                height: _flagHeight,
                width: double.infinity,
                child: const Center(child: CircularProgressIndicator()),
              ),
              cacheColorFilter: true,
            ),
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
