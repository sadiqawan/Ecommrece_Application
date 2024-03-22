import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  Future<List<DocumentSnapshot>> searchFirestore(String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('name',  isLessThanOrEqualTo: searchTerm)
        .get();

    return snapshot.docs;
  }
}
