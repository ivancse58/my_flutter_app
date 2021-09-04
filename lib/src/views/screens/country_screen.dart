import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../widgets/country_favorite_widget.dart';

class CountryScreen extends StatelessWidget {
  static const routeName = '/country-item';
  static const _flagHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context, listen: false);
    final name = countryProvider.item?.name;
    final flag = countryProvider.item?.flag;
    final callingCode = countryProvider.callingCode;
    final language = countryProvider.language;
    final favKey = FavKey(countryProvider.item?.alpha2Code, countryProvider.item?.alpha3Code);

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
                  _getFlagView(flag!),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              _getContainer(name, Theme.of(context).textTheme.headline1),
                              SizedBox(height: 16),
                              _getContainer(callingCode, Theme.of(context).textTheme.headline6),
                              SizedBox(height: 16),
                              _getContainer(language, Theme.of(context).textTheme.headline6),
                              SizedBox(height: 16)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CountryFavoriteWidget(-1, favKey),
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

  Widget _getFlagView(String flag) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: SvgWidget(flag, CountryScreen._flagHeight),
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
