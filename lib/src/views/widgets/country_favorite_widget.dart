import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatefulWidget {
  final FavKey favKey;

  CountryFavoriteWidget(this.favKey);

  @override
  _CountryFavoriteWidgetState createState() =>
      _CountryFavoriteWidgetState(favKey);
}

class _CountryFavoriteWidgetState extends State<CountryFavoriteWidget> {
  final SetFavCountryUseCase _setFavCountry = injector<SetFavCountryUseCase>();
  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();
  final _logger = DebugLogger();

  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);

  _CountryFavoriteWidgetState(FavKey favKey) {
    _logger.log('_CountryFavoriteWidgetState enter');
    _getFavCountry.call(params: favKey).then(
          (val) => setState(() {
            _logger.log("getFav: $val");
            _isFav.value = val;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    _logger.log('_CountryFavoriteWidgetState Widget build');

    return Center(
      child: ValueListenableBuilder<bool>(
        builder: (BuildContext context, bool value, Widget? child) {
          final icon = value ? Icons.star : Icons.star_border;
          return IconButton(
              icon: Icon(icon),
              color: Theme.of(context).errorColor,
              onPressed: () => _setFav());
        },
        valueListenable: _isFav,
      ),
    );
  }

  void _setFav() {
    _logger.log("setFav: ${widget.favKey.alpha2Code}");
    _logger.log("setFav: ${widget.favKey.alpha3Code}");
    _setFavCountry.call(params: widget.favKey).then(
          (val) => setState(() {
            _isFav.value = val;
          }),
        );
  }
}
