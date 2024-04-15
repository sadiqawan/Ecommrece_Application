import 'package:ecommrece_application/controls/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminState();
}

class _AdminState extends State<AdminScreen> {
  TextEditingController? titleC, desC, priceC,brandNameC,brandDesC;

  @override
  void initState() {
    titleC = TextEditingController();
    desC = TextEditingController();
    priceC = TextEditingController();
    brandNameC = TextEditingController();
    brandDesC = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    titleC!.dispose();
    desC!.dispose();
    priceC!.dispose();
    brandNameC!.dispose();
    brandDesC!.dispose();
    super.dispose();
  }

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
              const Text('Upload Products',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const  SizedBox(height: 20,),
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
                              context
                                  .read<AdminProvider>()
                                  .pickImageFrom(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('From Gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                              context
                                  .read<AdminProvider>()
                                  .pickImageFrom(ImageSource.gallery);
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
              InkWell(
                onTap: () {
                  if (titleC != null && priceC != null && desC != null) {
                    String title = titleC!.text.toString().trim();
                    String price = priceC!.text.toString().trim();
                    String description = desC!.text.toString().trim();

                    if (title.isNotEmpty &&
                        price.isNotEmpty &&
                        description.isNotEmpty) {
                      context.read<AdminProvider>().uploadTask(
                            context,
                            title,
                            price,
                            description,
                          );
                    } else {
                      Fluttertoast.showToast(msg: 'Please fill in all fields');
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Please fill in all fields');
                  }
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: context.watch<AdminProvider>().uploading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),



              const  SizedBox(height: 25,),

              const Text('Upload Brands',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const  SizedBox(height: 20,),

              const  SizedBox(height: 20,),
              TextField(
                controller: brandNameC,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                  labelText: 'Brand Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: brandDesC,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                  labelText: ' Brand Description',
                ),
                maxLines: 4,
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
                              context
                                  .read<AdminProvider>()
                                  .pickImageFromForBra(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('From Gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                              context
                                  .read<AdminProvider>()
                                  .pickImageFromForBra(ImageSource.gallery);
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
              const Text('Attach Logo'),

              const SizedBox(
                height: 15,
              ),

              InkWell(
                onTap: () {
                  if (brandNameC != null && brandDesC != null) {
                    String brandName = brandNameC!.text.toString().trim();
                    String description = brandDesC!.text.toString().trim();

                    if (brandName.isNotEmpty &&
                        description.isNotEmpty) {
                      context.read<AdminProvider>().uploadBrandTask(
                        context,
                        brandName,
                        description,
                      );
                    } else {
                      Fluttertoast.showToast(msg: 'Please fill in all fields');
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Please fill in all fields');
                  }
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: context.watch<AdminProvider>().brUploading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
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
