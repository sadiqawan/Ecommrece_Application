import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controls/providers/shopping_card_provider.dart';
import '../modes/custom_wedgits/custom_drawer.dart';
import '../controls/providers/search_provider.dart';

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
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: Provider.of<SearchProvider>(context)
                  .searchFirestoreStream(_searchController.text),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: SpinKitSpinningLines(color: Colors.black),
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
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(doc['name'].toString()),
                          subtitle: Text('\$: ${doc['price'].toString()}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              context.read<ShoppingCardProvider>().setCardItems(
                                  index, doc['image'], doc['name']);

                              Fluttertoast.showToast(
                                msg: 'Added To Card',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
}
