import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'models/country.dart';
import 'providers/countires.dart';
import 'screens/country_screen.dart';
import 'screens/main_screen.dart';
import 'services/api_service.dart';
import 'widgets/country_favorite_widget.dart';

void main() async {
  Hive.registerAdapter(CountryModelAdapter());
  Hive.registerAdapter(LanguageModelAdapter());
  Hive.registerAdapter(CurrencyModelAdapter());
  await openBox(APIService.boxName);
  await openBox(CountryFavoriteWidget.boxName);
  runApp(MyHomePage(key: GlobalKey()));
}

Future openBox(String boxName) async {
  // We get the current app directory
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  //Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(appDocumentDirectory.path);

  return await Hive.openBox(boxName);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Countries(),
        ),
      ],
      child: MaterialApp(
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
        ),
        initialRoute: '/',
        // default is '/'
        routes: {
          '/': (ctx) => MainScreen(),
          CountryScreen.routeName: (ctx) => CountryScreen(),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => MainScreen(),
          );
        },
      ),
    );
  }
}
