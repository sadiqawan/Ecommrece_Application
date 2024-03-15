import 'package:flutter/material.dart';

class FavouriteItem {
  final int index;
  final String image;
  final String name;

  FavouriteItem({
    required this.index,
    required this.image,
    required this.name,
  });
}

class FavouriteProvider extends ChangeNotifier {
  List<FavouriteItem> favouriteItems = [];

  void setFavouriteItem(int index, String image, String name) {
    favouriteItems.add(FavouriteItem(index: index, image: image, name: name));
    notifyListeners();
  }

  void removeFavouriteItem(int index) {
    favouriteItems.removeWhere((item) => item.index == index);
    notifyListeners();
  }
}
