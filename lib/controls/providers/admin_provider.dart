import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  late File? productImage;
  late bool uploading = false;


  Future<void> pickImageFrom(ImageSource imageSource) async {
    // Pick image from image source
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;
    productImage = File(xFile.path);
    notifyListeners();
  }

  Future<void> uploadTask(BuildContext context, String titleC, String priceC,
      String desC) async {
    FirebaseStorage storage = FirebaseStorage.instance;


    var fileName = '${titleC.trim()}.png';

    UploadTask uploadTask = storage
        .ref()
        .child(fileName)
        .putFile(productImage!, SettableMetadata(contentType: 'image/png'));

    try {
      uploading = true;
      notifyListeners();

      TaskSnapshot snapshot = await uploadTask;

      String productUrl = await snapshot.ref.getDownloadURL();
      // print(productUrl);

      await FirebaseFirestore.instance.collection('products').add({
        'name': titleC.trim(),
        'price': priceC.trim(),
        'discreption': desC.trim(), // corrected spelling here
        'image': productUrl,
      });

      Fluttertoast.showToast(msg: 'Data uploaded');
      Navigator.of(context).pop(); // Close the current screen

      uploading = false; // Set uploading to false after successful upload
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error uploading data: $error');
      uploading = false; // Set uploading to false if an error occurs
      notifyListeners();
      // Show error message or handle error as needed
      Fluttertoast.showToast(msg: 'Error uploading data. Please try again.');
    }
  }
}
