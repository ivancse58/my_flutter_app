import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  final String _url;
  final double _height;

  SvgWidget(this._url, this._height);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      _url,
      height: _height,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholderBuilder: (BuildContext ctx) => Container(
        height: _height,
        width: double.infinity,
        child: const Center(child: CircularProgressIndicator()),
      ),
      cacheColorFilter: true,
    );
  }
}
