import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CustomerHomeProvider extends ChangeNotifier {
  CollectionReference? productsRef;
  List<DocumentSnapshot>? products;
  // List to hold product documents

  CustomerHomeProvider() {
    // Initialize productsRef in the constructor
    productsRef = FirebaseFirestore.instance.collection('products');
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
}
