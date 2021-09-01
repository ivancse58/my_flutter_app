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

class CountryWidget extends StatelessWidget {
  static const _flagHeight = 250.0;

  final CountryModel item;
  final Function(CountryModel) getLanguage;

  CountryWidget(this.item, this.getLanguage);

  void selectCountry(BuildContext ctx, String lanStr, String callingCodeStr) {
    Provider.of<CountryProvider>(ctx, listen: false)
        .setCountry(item, lanStr, callingCodeStr);
    Navigator.of(ctx).pushNamed(CountryScreen.routeName);
  }

  /*String _getLanguage() {
    var languages = StringBuffer();
    final items = item.languages!.map((e) => e.name).toList();
    for (int i = 0; i < items.length; i++) {
      languages.write(items[i]);
      if (i + 1 < items.length) languages.write(', ');
    }
    return languages.toString();
  }*/

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
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name!,
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
                        CountryFavoriteWidget(
                            FavKey(item.alpha2Code, item.alpha3Code)),
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
