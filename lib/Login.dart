/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:scoped_model/scoped_model.dart';

import 'main.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "User name",
                hintText: "user@test.com",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
                  val.contains("@") ? null : "not_valid_username",
            ),
            const SizedBox(height: 50.0),
            ScopedModelDescendant<AppModel>(
                builder: (context, child, model) => MaterialButton(
                      onPressed: () {
                        //model.changeDirection();
                      },
                      height: 60.0,
                      color: const Color.fromRGBO(119, 31, 17, 1.0),
                      child: new Text(
                        "language",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}

class AppModel  extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
*/
