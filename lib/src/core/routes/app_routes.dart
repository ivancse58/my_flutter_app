import 'package:flutter/material.dart';
import 'package:my_flutter_app/src/views/screens/country_screen.dart';
import 'package:my_flutter_app/src/views/screens/main_screen.dart';
// code copy from : https://github.com/devmuaz/flutter_clean_architecture under MIT License

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    print(settings.arguments);
    switch (settings.name) {
      case CountryScreen.routeName:
        return _materialRoute(CountryScreen());

      default:
        return _materialRoute(MainScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
