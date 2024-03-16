import 'package:ecommrece_application/modes/custom_wedgits/add_to_card_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../controls/providers/shopping_card_provider.dart';
import '../modes/custom_wedgits/custom_drawer.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'bagzz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // ElevatedButton(onPressed: (){
          //   setState(() {});
          //
          // }, child: const Text('Search')),
          // ElevatedButton(onPressed: (){
          //   _searchController.clear();
          //   setState(() {});
          //
          // }, child: const Text('Clear')),

          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: _searchFirestore(_searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const  Center(
                    child: SpinKitSpinningLines(
                        color: Colors.black
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<DocumentSnapshot>? searchResults = snapshot.data;
                  if (searchResults != null && searchResults.isNotEmpty) {
                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = searchResults[index];
                        return ListTile(
                            leading: SizedBox(
                              child: Image.network(
                                doc['image'].toString(),
                                fit: BoxFit.cover, // adjust the fit property as needed
                              ),
                            ),
                            title: Text(doc['name'].toString()),
                            subtitle: Text('\$:  ${doc['price'].toString()}'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ShoppingCardProvider>()
                                    .setCardItems(index , doc['image'], doc['name']);

                                Fluttertoast.showToast(
                                    msg: 'Added To Card',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );


                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                              ),
                              child: const Text(
                                'ADD TO CARD',
                                style: TextStyle(color: Colors.white),
                              ),
                            )

                        );
                      },
                    );

                  } else {
                    return const Center(
                      child: Text('No results found.'),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<List<DocumentSnapshot>> _searchFirestore(String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('name', isLessThanOrEqualTo: searchTerm)
        .get();

    return snapshot.docs;
  }


  // Widget _buildSearchResults() {
  //   return
  // }
}
