import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
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
}
