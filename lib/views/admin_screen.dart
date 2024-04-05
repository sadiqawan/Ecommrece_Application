import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminState();
}

class _AdminState extends State<AdminScreen> {
  DocumentSnapshot? productSnapshot;
  File? productImage;
  TextEditingController? titleC, desC, priceC;

  @override
  void initState() {
    titleC = TextEditingController();
    desC = TextEditingController();
    priceC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleC!.dispose();
    desC!.dispose();
    priceC!.dispose();
    super.dispose();
  }

  pickImageFrom(ImageSource imageSource) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);

    if (xFile == null) return;

    productImage = File(xFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;

    var fileName = titleC!.text.trim() + '.png';

    UploadTask uploadTask = storage
        .ref()
        .child(fileName)
        .putFile(productImage!, SettableMetadata(contentType: 'image/png'));

    TaskSnapshot snapshot = await uploadTask;

    String productUrl = await snapshot.ref.getDownloadURL();
    print(productUrl);

    await FirebaseFirestore.instance.collection('products').add({
      'name': titleC!.text.trim(),
      'price': priceC!.text.trim(),
      'description': desC!.text.trim(),
      'image': productUrl,
    });

    Fluttertoast.showToast(msg: 'Image uploaded');
  }

  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminScreen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleC,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: desC,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                maxLines: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: priceC,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('From Camera'),
                            onTap: () {
                              Navigator.of(context).pop();
                              pickImageFrom(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('From Gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                              pickImageFrom(ImageSource.gallery);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.attach_file,
                  size: 50,
                ),
              ),
              const Text('Attach Image'),
              const SizedBox(
                height: 15,
              ),
              _isUploading
                  ? const CircularProgressIndicator()
                  : InkWell(
                onTap: () async {
                  setState(() {
                    _isUploading = true; // Set the uploading state to true
                  });
                  try {
                    await FirebaseFirestore.instance.collection('products').add({
                      'name': titleC!.text.trim(),
                      'price': priceC!.text.trim(),
                      'discreption': desC!.text.trim(),
                      'image': null,
                    });
                    // Reset the state after successful upload
                    setState(() {
                      _isUploading = false;
                      Fluttertoast.showToast(msg: 'Successfully uploaded');
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    print(e.toString());
                    // Reset the state if an error occurs
                    setState(() {
                      _isUploading = false;
                    });
                  }
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
