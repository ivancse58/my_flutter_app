import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/country.dart';

class CountryFavoriteWidget extends StatefulWidget {
  static const boxName = 'CountryFavorite';
  final CountryModel item;

  CountryFavoriteWidget(this.item);

  bool _isFavorite(Box box) {
    var key = item.alpha2Code.toString() + '-' + item.alpha3Code.toString();
    final bool? value = (box).get(key) as bool?;
    var val = false;
    if (value != null) val = value;
    return val;
  }

  void _setAsFavorite(Box box) {
    var val = _isFavorite(box);
    var key = item.alpha2Code.toString() + '-' + item.alpha3Code.toString();

    box.put(key, !val);
    print(val);
  }

  @override
  _CountryFavoriteWidgetState createState() => _CountryFavoriteWidgetState();
}

class _CountryFavoriteWidgetState extends State<CountryFavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: Hive.box(CountryFavoriteWidget.boxName).listenable(),
        builder: (context, box, widgetD) {
          final isFav = widget._isFavorite(box as Box);
          final icon = isFav ? Icons.star : Icons.star_border;
          return IconButton(
              icon: Icon(icon),
              color: Theme.of(context).errorColor,
              onPressed: () => widget._setAsFavorite(box));
        },
      ),
    );
  }
}
