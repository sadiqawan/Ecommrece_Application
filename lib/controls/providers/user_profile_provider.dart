import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../views/login_screen.dart';

class UserProfileProvider extends ChangeNotifier {
  File? chosenImage;
  DocumentSnapshot? userSnapshot;
  bool showLocalImage = false;



  // getting user details

  Future<void> getUserSnapshot() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
  }

  // for user account deletion

  Future<void> getUserDelete( BuildContext context) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      var uid = currentUser.uid;

      // Delete user data from Firestore
      await FirebaseFirestore.instance.collection('user').doc(uid).delete();

      // Delete the user account
      await currentUser.delete();
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
      // You might want to call notifyListeners() if this method is part of a class that extends ChangeNotifier.
      notifyListeners();
    }
  }


// for picking image from device
  Future<void> pickImageFrom(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;

    chosenImage = File(xFile.path);



    // upload image to storage
    FirebaseStorage storage = FirebaseStorage.instance;

    var fileName = userSnapshot!['email'] + '.png';

    UploadTask uploadTask = storage
        .ref()
        //.child('profile_images')
        .child(fileName)
        .putFile(chosenImage!, SettableMetadata(contentType: 'image/png'));

    TaskSnapshot snapshot = await uploadTask;

    String profileImageUrl = await snapshot.ref.getDownloadURL();
    print(profileImageUrl);

    // save its url in users collection

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'photo': profileImageUrl});

    Fluttertoast.showToast(msg: 'Profile image uploaded');
    showLocalImage = true;
    notifyListeners();
  }
}
