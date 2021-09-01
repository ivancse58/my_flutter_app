import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/views/providers/fav_provider.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../widgets/country_favorite_widget.dart';

class CountryScreen extends StatelessWidget {
  static const routeName = '/country-item';
  static const _flagHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);
    final name = countryProvider.item?.name;
    final favKey = countryProvider.favKey;
    final flag = countryProvider.item?.flag;
    final callingCode = countryProvider.callingCode;
    final language = countryProvider.language;

    Provider.of<CountryFavProvider>(context, listen: false)
        .setInitFavoriteStatus(favKey!, false);

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
                          child: SvgWidget(flag!, _flagHeight),
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
                              callingCode!,
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
                                language!,
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
          ],
        ),
      ),
    );
  }
}
