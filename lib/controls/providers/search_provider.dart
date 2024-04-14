import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  // Future<List<DocumentSnapshot>> searchFirstore(String searchTerm) async {
  //   if (searchTerm.isEmpty) {
  //     return [];
  //   }
  //   final QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('products')
  //       .where('name', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
  //       .where('name', isGreaterThanOrEqualTo: searchTerm.toUpperCase())
  //       .where('name', isLessThanOrEqualTo: '${searchTerm.toLowerCase()}\uf8ff')
  //       .where('name', isLessThanOrEqualTo: '${searchTerm.toUpperCase()}\uf8ff')
  //       .get();
  //
  //   return snapshot.docs;
  // }

  Stream<List<DocumentSnapshot>> searchFirestoreStream(String searchTerm) {
    StreamController<List<DocumentSnapshot>> _controller =
    StreamController<List<DocumentSnapshot>>();

    // Convert search term to lowercase
    String searchTermLowerCase = searchTerm.toLowerCase();
    String searchTermUpperCase = searchTerm.toUpperCase();

    // Listen to changes in searchTerm
    StreamSubscription<QuerySnapshot> subscription;
    subscription = FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: searchTermLowerCase)
        .where('name', isLessThanOrEqualTo: '$searchTermLowerCase\uf8ff')
        .snapshots()
        .listen((snapshot) {
      _controller.add(snapshot.docs);
    });

    // Cancel the subscription when the stream is closed
    _controller.onCancel = () {
      subscription.cancel();
    };

    return _controller.stream;
  }
}

//
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class SearchProvider extends ChangeNotifier {
//   Future<List<DocumentSnapshot>> searchFirstore(String searchTerm) async {
//     if (searchTerm.isEmpty) {
//       return [];
//     }
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .where('name',  isLessThanOrEqualTo: searchTerm)
//         .get();
//
//     return snapshot.docs;
//   }

//   Stream<List<DocumentSnapshot>> searchFirestoreStream(String searchTerm) {
//     StreamController<List<DocumentSnapshot>> _controller =
//     StreamController<List<DocumentSnapshot>>();
//
//     // Initial empty list
//     _controller.add([]);
//
//     // Listen to changes in searchTerm
//     StreamSubscription subscription;
//     subscription = FirebaseFirestore.instance
//         .collection('products')
//         .where('name', isLessThanOrEqualTo: searchTerm)
//         .snapshots()
//         .listen((snapshot) {
//       _controller.add(snapshot.docs);
//     });
//
//     // Cancel the subscription when the stream is closed
//     _controller.onCancel = () {
//       subscription.cancel();
//     };
//
//     return _controller.stream;
//   }
// }



// Future<List<DocumentSnapshot>> searchFirstore(String searchTerm) async {
//     if (searchTerm.isEmpty) {
//       return [];
//     }
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .where('name',  isLessThanOrEqualTo: searchTerm)
//         .get();
//
//     return snapshot.docs;
//   }