import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:startup_namer/widgets/country_favorite_widget.dart';

class CountryScreen extends StatelessWidget {
  static const routeName = '/country-item';
  static const _flagHeight = 250.0;

  /*final CountryModel selectedCountry;

  CountryScreen(this.selectedCountry);*/

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final name = routeArgs['name'];
    final alpha2 = routeArgs['alpha2'];
    final alpha3 = routeArgs['alpha3'];
    final flag = routeArgs['flag'];
    final callingCode = routeArgs['callingCode'];
    final language = routeArgs['language'];

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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              'Calling Codes: $callingCode',
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
                                'Languages: $language',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 16,
                                ),
                              ),
                              CountryFavoriteWidget(alpha2, alpha3),
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
