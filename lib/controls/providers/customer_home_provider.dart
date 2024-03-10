import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CustomerHomeProvider extends ChangeNotifier {
  List  productList = [];
  Future<void> productsData() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Example: Fetching data from a collection named 'labels'
      QuerySnapshot querySnapshot = await firebaseFirestore.collection('products').get();

      // Process the documents in the snapshot
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (QueryDocumentSnapshot document in documents) {
        // Access document fields using document.data()
        Object? data = document.data();
        // Do something with the data
        print(data);
        productList.add(data);
      }

    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
    }
  }
}
