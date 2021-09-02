import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatelessWidget {
  final SetFavCountryUseCase _setFavCountry = injector<SetFavCountryUseCase>();

  final Function _updateState;
  final FavKey _favKey;
  final bool _isFav;

  CountryFavoriteWidget(
    this._isFav,
    this._favKey,
    this._updateState,
  );

  @override
  Widget build(BuildContext context) {
    final icon = _isFav ? Icons.star : Icons.star_border;

    return Center(
      child: IconButton(
          icon: Icon(icon),
          color: Theme.of(context).errorColor,
          onPressed: () => _setFav(_favKey)),
    );
  }

  void _setFav(FavKey favKey) {
    _setFavCountry.call(params: favKey).then(
          (val) => {_updateState(val)},
        );
  }
}
