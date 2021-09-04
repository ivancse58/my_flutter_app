import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/country_fav.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';
import 'package:my_flutter_app/src/views/providers/fav_country_provider.dart';
import 'package:provider/provider.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatefulWidget {
  final FavKey _favKey;

  CountryFavoriteWidget(this._favKey);

  @override
  _CountryFavoriteWidgetState createState() => _CountryFavoriteWidgetState();
}

class _CountryFavoriteWidgetState extends State<CountryFavoriteWidget> {
  final SetFavCountryUseCase _setFavCountry = injector<SetFavCountryUseCase>();

  final GetFavCountryUseCase _getFavCountry = injector<GetFavCountryUseCase>();

  @override
  void initState() {
    _getFav(widget._favKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<FavCountryProvider>(
        builder: (_, favCountryProvider, ch) => IconButton(
          icon: Icon(
            (favCountryProvider.getFavModel(widget._favKey)?.isFav == false)
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
    _setFavCountry.call(params: widget._favKey).then(
          (val) => _setProvider(val),
        );
  }

  void _getFav(FavKey favKey) {
    _getFavCountry.call(params: favKey).then(
          (val) => _setProvider(val),
        );
  }

  void _setProvider(bool isFav) {
    final provider = Provider.of<FavCountryProvider>(context, listen: false);
    final favModel = provider.getFavModel(widget._favKey);
    if (favModel != null) {
      final newFavModel = CountryFavModel(
        favModel.countryModel,
        favModel.favKey,
        favModel.key,
        isFav,
      );
      provider.updateFavModel(newFavModel);
    }
  }
}
