import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/core/utils/debug_logger.dart';
import 'package:my_flutter_app/src/domain/entities/country_fav.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';
import 'package:my_flutter_app/src/views/providers/fav_country_provider.dart';
import 'package:my_flutter_app/src/views/providers/fav_remove_provider.dart';
import 'package:provider/provider.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatelessWidget {
  final FavKey _favKey;
  final int _index;

  CountryFavoriteWidget(this._index, this._favKey);

  final SetFavCountryUseCase _setFavCountry = injector<SetFavCountryUseCase>();

  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();

  late final FavCountryProvider provider;
  late final FavRemoveProvider favRemoveProvider;

  @override
  Widget build(BuildContext context) {
    favRemoveProvider = Provider.of<FavRemoveProvider>(context, listen: false);
    provider = Provider.of<FavCountryProvider>(context, listen: false);

    _getFav(_favKey);
    return Center(
      child: Consumer<FavCountryProvider>(
        builder: (_, favCountryProvider, ch) => IconButton(
          icon: Icon(
            (favCountryProvider.getFavModel(_favKey)?.isFav == false)
                ? Icons.star_border
                : Icons.star,
          ),
          color: Theme.of(context).errorColor,
          onPressed: () => _setFav(),
        ),
      ),
    );
  }

  void _setFav() {
    _setFavCountry.call(params: _favKey).then(
          (val) => _setProvider(val, true),
        );
  }

  void _getFav(FavKey favKey) {
    DebugLogger().log("CountryFavoriteWidget _getFav ");
    _getFavCountry.call(params: favKey).then(
          (val) => {_setProvider(val, false)},
        );
  }

  void _setProvider(bool isFav, bool sendNotification) {
    if (!isFav && sendNotification) favRemoveProvider.remoteItem(_index);

    final favModel = provider.getFavModel(_favKey);
    if (favModel != null) {
      final newFavModel = CountryFavModel(
        favModel.countryModel,
        favModel.favKey,
        favModel.key,
        isFav,
      );
      DebugLogger().log("Set fav provider $isFav");

      provider.updateFavModel(newFavModel);
    }
  }
}
