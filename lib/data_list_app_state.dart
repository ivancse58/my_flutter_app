import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';
import 'models/country.dart';
import 'services/api_service.dart';
import 'widgets/country_favorite_widget.dart';
import 'widgets/country_widget.dart';

class DataListAppState extends State<MyApp> {
  late Future<List<CountryModel>> futureCountries;
  final APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    futureCountries = apiService.fetchCountry();
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
          child: FutureBuilder<List<CountryModel>>(
            future: futureCountries,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: snapshot.data?.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return CountryWidget(item);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
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
