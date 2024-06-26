import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommrece_application/controls/providers/user_profile_provider.dart';
import 'package:ecommrece_application/views/admin_screen.dart';
import 'package:ecommrece_application/views/login_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            StreamBuilder<DocumentSnapshot>(
              stream: context.watch<UserProfileProvider>().userSnapshotStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.black); // Placeholder while loading
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Handle error state
                }
                final value = snapshot.data;
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: (value != null && value['photo'] != null)
                      ? Image.network(
                    value['photo'] as String,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'images/person.jpg',
                    fit: BoxFit.cover,
                  ), // Display an empty container if no image is available
                );
              },
            ),

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
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<UserProfileProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: value.userSnapshotStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitSpinningLines(
                            color: Colors.black,
                          ); // While loading
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // If there's an error
                        } else if (!snapshot.hasData ||
                            !snapshot.data!.exists) {
                          return const Center(
                            child: Text('Document does not exist'),
                          ); // If the document doesn't exist
                        } else {
                          var userSnapshot = snapshot.data!; // Access user data
                          var data = userSnapshot.data() as Map<String,
                              dynamic>; // Cast data to Map<String, dynamic>
                          // Use user data to build your UI
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProfileNameContainer(
                                text: 'Name: ${data['name']}',
                              ),
                              ProfileNameContainer(
                                text: 'Email: ${data['email']}',
                              ),
                              ProfileNameContainer(
                                text: 'Contact: ${data['phone']}',
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                );
              },
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
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete your account?"
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Call the method to delete the user account
                            context.read<UserProfileProvider>().getUserDelete();
                            Navigator.of(context).pop();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );// Close the dialog
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
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

          ],
        ),
      ),
    );
  }
}
