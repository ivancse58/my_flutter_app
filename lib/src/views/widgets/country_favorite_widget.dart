import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/domain/entities/fav_key.dart';
import 'package:my_flutter_app/src/domain/usecase/get_fav_country_usecase.dart';
import 'package:my_flutter_app/src/domain/usecase/set_fav_country_usecase.dart';
import 'package:my_flutter_app/src/utils/debug_logger.dart';

import '../../injector.dart';

class CountryFavoriteWidget extends StatefulWidget {
  final FavKey favKey;
  final bool isGrid;

  CountryFavoriteWidget(this.favKey, [this.isGrid = false]);

  @override
  _CountryFavoriteWidgetState createState() =>
      _CountryFavoriteWidgetState(favKey);
}

class _CountryFavoriteWidgetState extends State<CountryFavoriteWidget> {
  final SetFavCountryUseCase _setFavCountryUseCase =
      injector<SetFavCountryUseCase>();
  final GetFavCountryUseCase _getFavCountryUseCase =
      injector<GetFavCountryUseCase>();
  final _logger = DebugLogger();

  //bool _isFav = false;
  final ValueNotifier<bool> _isFav = ValueNotifier<bool>(false);

  _CountryFavoriteWidgetState(FavKey favKey) {
    _getFavCountryUseCase.call(params: favKey).then((val) => setState(() {
          _isFav.value = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
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
    _logger.log("setFav: ${widget.favKey}");
    _setFavCountryUseCase
        .call(params: widget.favKey)
        .then((val) => setState(() {
              _isFav.value = val;
            }));
  }
}
