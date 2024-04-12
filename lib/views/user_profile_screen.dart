import 'package:ecommrece_application/controls/providers/user_profile_provider.dart';
import 'package:ecommrece_application/views/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../modes/custom_wedgits/profile_show_name_container.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // DocumentSnapshot? userSnapshot;
  // File? chosenImage;
  // bool showLocalImage = false;
  //
  // getUserDetails() async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   userSnapshot =
  //       await FirebaseFirestore.instance.collection('user').doc(uid).get();
  //
  //   setState(() {});
  // }

  // pickImageFrom(ImageSource imageSource) async {
  //   XFile? xFile = await ImagePicker().pickImage(source: imageSource);
  //
  //   if (xFile == null) return;
  //
  //   chosenImage = File(xFile.path);
  //   setState(() {
  //     showLocalImage = true;
  //   });
  //
  //   // upload image to storage
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //
  //   var fileName = userSnapshot!['email'] + '.png';
  //
  //   UploadTask uploadTask = storage
  //       .ref()
  //       //.child('profile_images')
  //       .child(fileName)
  //       .putFile(chosenImage!, SettableMetadata(contentType: 'image/png'));
  //
  //   TaskSnapshot snapshot = await uploadTask;
  //
  //   String profileImageUrl = await snapshot.ref.getDownloadURL();
  //   print(profileImageUrl);
  //
  //   // save its url in users collection
  //
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(uid)
  //       .update({'photo': profileImageUrl});
  //
  //   Fluttertoast.showToast(msg: 'Profile image uploaded');
  // }

  @override
  void initState() {
    Provider.of<UserProfileProvider>(context, listen: false).getUserSnapshot();
    // getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'MY PROFILE',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Consumer<UserProfileProvider>(builder: (context, value, child) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: (value.showLocalImage && value.chosenImage != null)
                    ? Image.file(value.chosenImage!, fit: BoxFit.cover)
                    : ((value.userSnapshot != null &&
                            value.userSnapshot!['photo'] != null)
                        ? Image.network(
                            value.userSnapshot!['photo'] as String,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/person.jpg')), // Display an empty container if no image is available
              );
            }),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
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
                            context
                                .read<UserProfileProvider>()
                                .pickImageFrom(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text('From Gallery'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<UserProfileProvider>()
                                .pickImageFrom(ImageSource.gallery);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<UserProfileProvider>(
                      builder: (context, value, child) {
                    return Center(
                        child: value.showLocalImage
                            ? const Text(
                                'UPDATE PIC',
                                style: TextStyle(color: Colors.white),
                              )
                            : const Text(
                                'UPLOAD PIC',
                                style: TextStyle(color: Colors.white),
                              ));
                  })),
            ),
            const SizedBox(height: 20),
            Consumer<UserProfileProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileNameContainer(
                          text: 'Name: ${value.userSnapshot?['name']}'),
                      ProfileNameContainer(
                          text: 'Email: ${value.userSnapshot?['email']}'),
                      ProfileNameContainer(
                          text: 'Contact: ${value.userSnapshot?['phone']}'),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                context.read<UserProfileProvider>().getUserDelete(context);
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
                    'Delete MyAccount',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AdminScreen();
                }));
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
                    'AdminScreen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
