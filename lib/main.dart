import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_app/src/core/routes/app_routes.dart';
import 'package:my_flutter_app/src/core/themes/app_theme.dart';
import 'package:my_flutter_app/src/injector.dart';
import 'package:my_flutter_app/src/views/providers/country_provider.dart';
import 'package:my_flutter_app/src/views/providers/fav_country_provider.dart';
import 'package:my_flutter_app/src/views/providers/fav_remove_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Alice alice = Alice(
    showNotification: true, showInspectorOnShake: true, darkTheme: false, maxCallsCount: 1000);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies(openBox, alice);
  runApp(MyHomePage(key: GlobalKey()));
}

Future openBox(String boxName) async {
  if(kIsWeb){
    await Hive.initFlutter();
  }else{
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
  }
  return await Hive.openBox(boxName);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({required Key key}) : super(key: key);

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CountryProvider()),
        ChangeNotifierProvider.value(value: FavCountryProvider()),
        ChangeNotifierProvider.value(value: FavRemoveProvider()),
      ],
      child: MaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        title: 'Fetch Data Example',
        theme: AppTheme.light,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
