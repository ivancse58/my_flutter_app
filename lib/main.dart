import 'package:flutter/material.dart';

import 'dataListAppState.dart';

void main() {
  runApp(MyApp(
    key: GlobalKey(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({required Key key}) : super(key: key);

  /*@override
  _MyAppState createState() => _MyAppState();*/
  @override
  DataListAppState createState() => DataListAppState();
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}*/
