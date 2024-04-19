import 'package:ecommrece_application/modes/shopping_card_model.dart';
import 'package:flutter/material.dart';

class ShoppingCardProvider extends ChangeNotifier{

  List<ShoppingCardItem> cardItems = [];
  int  count = 0 ;



  void setCardItems(index, image, name , price){
    cardItems.add(ShoppingCardItem( name: name, image: image, index: index, price: price));
    notifyListeners();

  }
  void removeCardItems(index){
    cardItems.removeWhere((item) => item.index == index);
    notifyListeners();

  }

  void incrementCount(){

    count = count++;
    notifyListeners();
  }
 void decrementCount(){

    count = count--;
    notifyListeners();
  }


}