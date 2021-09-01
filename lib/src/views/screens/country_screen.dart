import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import '../../utils/app_messages.dart';
import '../providers/country_provider.dart';
import '../widgets/country_favorite_widget.dart';

class CountryScreen extends StatelessWidget {
  static const routeName = '/country-item';
  static const _flagHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    final country = Provider.of<CountryProvider>(context, listen: false);

    final name = country.item!.name;
    final alpha2 = country.item!.alpha2Code;
    final alpha3 = country.item!.alpha3Code;
    final flag = country.item!.flag;
    final callingCode =
        sprintf(AppMessages.label_calling_codes, [country.callingCodeStr]);
    final language = sprintf(AppMessages.label_languages, [country.lanStr]);
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
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
                            flag!,
                            height: _flagHeight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholderBuilder: (BuildContext ctx) => Container(
                              height: _flagHeight,
                              width: double.infinity,
                              child: const Center(
                                  child: CircularProgressIndicator()),
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
                              name,
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
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              CountryFavoriteWidget(FavKey(alpha2, alpha3)),
                            ],
                          ),
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
}
