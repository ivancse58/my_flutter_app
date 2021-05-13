import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/country.dart';
import 'services/api_service.dart';
import 'widgets/country_favorite_widget.dart';
import 'widgets/country_widget.dart';

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
  final APIService apiService = APIService();

  Widget buildEmptyWidget() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No data found! Try Again?',
              style: TextStyle(color: Colors.red),
            ),
            Icon(Icons.replay),
          ],
        ),
      ),
      onTap: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch All Countries'),
        ),
        body: Center(
          child: FutureBuilder(
            future: apiService.fetchCountryWithCache(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List countryList = apiService.countryList;
                if (countryList.contains(APIService.empty)) {
                  return buildEmptyWidget();
                } else
                  return RefreshIndicator(
                    onRefresh: () => apiService.updateData(() {
                      Fluttertoast.showToast(
                          msg: "Update to update data!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }, setState),
                    child: ListView.builder(
                      // Let the ListView know how many items it needs to build.
                      itemCount: countryList.length,
                      // Provide a builder function. This is where the magic happens.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (context, index) {
                        final item = countryList[index];
                        return CountryWidget(item);
                      },
                    ),
                  );
              } else if (snapshot.connectionState != ConnectionState.done ||
                  snapshot.hasError) {
                return buildEmptyWidget();
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
