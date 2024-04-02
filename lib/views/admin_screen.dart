import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminState();
}

class _AdminState extends State<AdminScreen> {
  late TextEditingController titleC, desC;

  @override
  void initState() {
    titleC = TextEditingController();
    desC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleC.dispose();
    desC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                  labelText: 'Title'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: desC,
              decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                  labelText: 'Description'),
              maxLines: 4,
            ),
            const SizedBox(
              height: 15,
            ),
            IconButton(
                onPressed: () {


                },
                icon: const Icon(
                  Icons.attach_file,
                  size: 50,
                )),
            const Text('Attach Image'),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {



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
                    'Uplode',
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
