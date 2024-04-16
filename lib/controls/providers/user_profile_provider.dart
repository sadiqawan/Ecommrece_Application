import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class UserProfileProvider extends ChangeNotifier {
  File? chosenImage;
  DocumentSnapshot? userSnapshot;
  bool showLocalImage = false;

  // Stream controller for user snapshot
  late Stream<DocumentSnapshot> _userSnapshotStream;

  // Constructor
  UserProfileProvider() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _userSnapshotStream =
        FirebaseFirestore.instance.collection('user').doc(uid).snapshots();
  }

  // Getter for user snapshot stream
  Stream<DocumentSnapshot> get userSnapshotStream => _userSnapshotStream;

  // for picking image from device
  Future<void> pickImageFrom(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;

    showLocalImage = true;
    notifyListeners();
    chosenImage = File(xFile.path);

    // Upload image to storage
    FirebaseStorage storage = FirebaseStorage.instance;

    var fileName = '${FirebaseAuth.instance.currentUser!.email!}.png';

    try {
      // Upload the file and get its task
      TaskSnapshot uploadTask = await storage
          .ref()
          .child(fileName)
          .putFile(chosenImage!, SettableMetadata(contentType: 'image/png'));

      // Get the download URL
      String profileImageUrl = await uploadTask.ref.getDownloadURL();
      print(profileImageUrl);

      // Save the URL in the user's collection
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .update({'photo': profileImageUrl});

      Fluttertoast.showToast(msg: 'Profile image uploaded');
    } catch (error) {
      // Handle any potential errors
      print('Error uploading image: $error');
      Fluttertoast.showToast(msg: 'Failed to upload profile image');
    }
  }

  // for user account deletion
  Future<void> getUserDelete() async {
    try {
      // Check if the current user is not null before deleting the account
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Delete the user account
        await currentUser.delete();
        // Clear user data from Firestore
        String uid = currentUser.uid;
        await FirebaseFirestore.instance.collection('user').doc(uid).delete();
        // Perform any additional cleanup
      } else {
        print('Error deleting user account: Current user is null');
      }
    } catch (error) {
      print('Error deleting user account: $error');
      Fluttertoast.showToast(msg: 'Something went wrong!' ,backgroundColor: Colors.red);
      // Handle any potential errors
    }
  }
}
