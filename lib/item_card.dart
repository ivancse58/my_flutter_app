import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'country.dart';

class CountryWidget extends StatelessWidget {
  final Country item;

  CountryWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Row(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.purple,
            width: 2,
          )),
          padding: EdgeInsets.all(10),
          child: Text(
            item.callingCodes!.first.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.purple,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              item.languages!.map((e) => e.name).toList().toString(),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )
      ]),
      elevation: 5,
    );
  }
}
