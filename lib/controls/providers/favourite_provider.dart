import 'package:flutter/material.dart';

import '../../modes/fovourite_items_model.dart';


class FavouriteProvider extends ChangeNotifier {
  List<FavouriteItem> favouriteItems = [];

  void setFavouriteItem(int index, String image, String name,int price) {
    favouriteItems.add(FavouriteItem(index: index, image: image, name: name, price: price));
    notifyListeners();
  }

  void removeFavouriteItem(int index) {
    favouriteItems.removeWhere((item) => item.index == index);
    notifyListeners();
  }
}
