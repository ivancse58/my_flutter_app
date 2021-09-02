import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';

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
  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);

  @override
  void initState() {
    _getFav(widget._favKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<bool>(
        builder: (BuildContext context, bool value, Widget? child) {
          final icon = value ? Icons.star : Icons.star_border;
          return IconButton(
              icon: Icon(icon), color: Theme.of(context).errorColor, onPressed: () => _setFav());
        },
        valueListenable: _isFav,
      ),
    );
  }

  void _setFav() {
    _setFavCountry.call(params: widget._favKey).then(
          (val) => setState(() {
            _isFav.value = val;
          }),
        );
  }

  void _getFav(FavKey favKey) {
    _getFavCountry.call(params: favKey).then(
          (val) => setState(() {
            _isFav.value = val;
          }),
        );
  }
}
