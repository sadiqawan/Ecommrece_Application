import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> favouriteItems = [];

  void setFavouriteItem(int index) {
    favouriteItems.add(index);
    notifyListeners();
  }

  void removeFavouriteItem(int index) {
    favouriteItems.remove(index);
    notifyListeners();
  }
}
