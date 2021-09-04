import 'package:flutter/material.dart';

class FavRemoveProvider with ChangeNotifier {
  int index = -1;

  void remoteItem(int index) {
    this.index = index;
    notifyListeners();
  }
}
