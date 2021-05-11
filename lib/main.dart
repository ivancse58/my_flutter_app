import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'data_list_app_state.dart';

void main() async {
  // We get the current app directory
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  //Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(appDocumentDirectory.path);

  var box = await Hive.openBox('settings');
  runApp(MyApp(key: GlobalKey()));
}

class MyApp extends StatefulWidget {
  MyApp({required Key key}) : super(key: key);

  @override
  DataListAppState createState() => DataListAppState();
}
