import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_app/src/core/routes/app_routes.dart';
import 'package:my_flutter_app/src/core/themes/app_theme.dart';
import 'package:my_flutter_app/src/injector.dart';
import 'package:my_flutter_app/src/views/providers/country_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies(openBox);
  runApp(MyHomePage(key: GlobalKey()));
}

Future openBox(String boxName) async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  return await Hive.openBox(boxName);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  /*Alice _alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      darkTheme: false,
      maxCallsCount: 1000);*/

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CountryProvider(),
        ),
      ],
      child: MaterialApp(
        //navigatorKey: _alice.getNavigatorKey(),
        title: 'Fetch Data Example',
        theme: AppTheme.light,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
