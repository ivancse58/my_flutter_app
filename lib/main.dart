import 'package:flutter/material.dart';

import 'data_list_app_state.dart';

void main() {
  runApp(MyApp(key: GlobalKey()));
}

class MyApp extends StatefulWidget {
  MyApp({required Key key}) : super(key: key);

  @override
  DataListAppState createState() => DataListAppState();
}
