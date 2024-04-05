import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  String? productTitle;
  String? productDescription;
  File? chooseImage;

  void productDetails(String productTitle, String productDescription) {
    // Implement your product details functionality here
  }

  Future<void> pickImageFrom(ImageSource imageSource) async {
    // Pick image from image source
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);

    if (pickedImage != null) {
      chooseImage = File(pickedImage.path);

      // Upload image to storage
      final storage = FirebaseStorage.instance;
      final fileName = FirebaseAuth.instance.currentUser!.email! + '.png';

      final ref = storage.ref().child(fileName);
      final uploadTask = ref.putFile(chooseImage!);
      final snapshot = await uploadTask;

      final profileImageUrl = await snapshot.ref.getDownloadURL();

      // Save image URL in user's collection
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'photo': profileImageUrl,
      });

      Fluttertoast.showToast(msg: 'Profile image uploaded');
    } else {
      // User canceled image picking
      Fluttertoast.showToast(msg: 'No image selected');
    }
  }
}
