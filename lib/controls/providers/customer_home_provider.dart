import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomerHomeProvider extends ChangeNotifier {
  CollectionReference? productsRef;
  CollectionReference? brandsRef;
  CollectionReference? promoRef;
  List<DocumentSnapshot>? products;
  List<DocumentSnapshot>? brands;
  List<DocumentSnapshot>? promo;


  // List to hold product documents

  CustomerHomeProvider() {
    // Initialize productsRef in the constructor
    productsRef = FirebaseFirestore.instance.collection('products');
    brandsRef = FirebaseFirestore.instance.collection('brands');
    promoRef = FirebaseFirestore.instance.collection('promo');
  }

  Future<void> fetchProducts() async {
    try {
      // Fetch product documents
      final QuerySnapshot snapshot = await productsRef!.get();
      products = snapshot.docs;
      notifyListeners(); // Notify listeners about the change
    } catch (e) {
      // Handle errors
      debugPrint('Error fetching products: $e');
    }
  }

  Future<void> fetchBrands() async {
    try {
      final QuerySnapshot snapshot = await brandsRef!.get();
      brands = snapshot.docs;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPromo() async {
    try {
      final QuerySnapshot snapshot = await promoRef!.get();
      promo = snapshot.docs;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }


}
