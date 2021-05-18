import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/api_service.dart';
import '../utils/app_messages.dart';
import '../utils/debug_logger.dart';
import '../widgets/country_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final logger = DebugLogger();
  final APIService apiService = APIService();

  Widget buildEmptyWidget(String errorMessage) {
    logger.log(errorMessage);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
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
    return Scaffold(
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
                return buildEmptyWidget(AppMessages.emptyMessage);
              } else
                return RefreshIndicator(
                  onRefresh: () => apiService.updateData((value) {
                    Fluttertoast.showToast(
                        msg: value,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
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
              return buildEmptyWidget(AppMessages.errorMessage);
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
