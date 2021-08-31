import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';
import 'package:my_flutter_app/src/utils/debug_logger.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatefulWidget {
  final logger = DebugLogger();
  static const boxName = 'CountryFavorite';
  final String? alpha2Code;
  final String? alpha3Code;

  CountryFavoriteWidget(this.alpha2Code, this.alpha3Code);

  @override
  _CountryFavoriteWidgetState createState() =>
      _CountryFavoriteWidgetState(alpha2Code, alpha3Code);
}

class _CountryFavoriteWidgetState extends State<CountryFavoriteWidget> {
  final SetFavCountryUseCase _setFavCountryUseCase =
      injector<SetFavCountryUseCase>();
  final GetFavCountryUseCase _getFavCountryUseCase =
      injector<GetFavCountryUseCase>();

  bool _isFav = false;

  _CountryFavoriteWidgetState(String? a, String? b) {
    _getFavCountryUseCase.call(params: FavKey(a, b)).then((val) => setState(() {
          _isFav = val;
        }));
  }

  void _setFav() {
    _setFavCountryUseCase
        .call(params: FavKey(widget.alpha2Code, widget.alpha3Code))
        .then((val) => setState(() {
              _isFav = val;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: Hive.box(CountryFavoriteWidget.boxName).listenable(),
        builder: (context, box, widgetD) {
          final icon = _isFav ? Icons.star : Icons.star_border;
          return IconButton(
              icon: Icon(icon),
              color: Theme.of(context).errorColor,
              onPressed: () => _setFav());
        },
      ),
    );
  }
}
