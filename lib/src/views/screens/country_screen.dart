import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/views/widgets/svg_widget.dart';
import 'package:provider/provider.dart';

import '../../injector.dart';
import '../providers/country_provider.dart';
import '../widgets/country_favorite_widget.dart';

class CountryScreen extends StatefulWidget {
  static const routeName = '/country-item';
  static const _flagHeight = 250.0;

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final _logger = DebugLogger();
  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);
  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();
  bool _dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    final countryProvider =
        Provider.of<CountryProvider>(context, listen: false);
    final name = countryProvider.item?.name;
    final flag = countryProvider.item?.flag;
    final callingCode = countryProvider.callingCode;
    final language = countryProvider.language;
    final favKey = FavKey(
      countryProvider.item?.alpha2Code,
      countryProvider.item?.alpha3Code,
    );
    // this is creating loop!
    if (!_dataLoaded) _getFav(favKey);

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
                          child: SvgWidget(flag!, CountryScreen._flagHeight),
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
          ],
        ),
      ),
    );
  }

  void _updateFavState(bool isFav) {
    _logger.log('CountryScreen _updateFavState $isFav');
    if (mounted)
      setState(() {
        _isFav.value = isFav;
      });
  }

  void _getFav(FavKey favKey) {
    _logger.log('CountryScreen _getFav');

    _dataLoaded = true;
    _getFavCountry.call(params: favKey).then(
          (val) => setState(() {
            _isFav.value = val;
          }),
        );
  }
}
