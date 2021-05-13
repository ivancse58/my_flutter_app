import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:startup_namer/screens/country_screen.dart';
import 'package:startup_namer/widgets/country_favorite_widget.dart';

import '../models/country.dart';

class CountryWidget extends StatelessWidget {
  static const _flagHeight = 250.0;

  final CountryModel item;

  CountryWidget(this.item);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CountryScreen.routeName,
      arguments: {
        'name': item.name,
        'alpha2': item.alpha2Code,
        'alpha3': item.alpha3Code,
        'flag': item.flag,
        'callingCode': item.callingCodes!.first.toString(),
        'language': getLanguage(),
      },
    );
  }

  String getLanguage() {
    var languages = StringBuffer();
    final items = item.languages!.map((e) => e.name).toList();
    for (int i = 0; i < items.length; i++) {
      languages.write(items[i]);
      if (i + 1 < items.length) languages.write(', ');
    }
    return languages.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'Calling Codes: ' + item.callingCodes!.first.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Languages: ' + getLanguage(),
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 16,
                          ),
                        ),
                        CountryFavoriteWidget(item.alpha2Code, item.alpha3Code),
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
