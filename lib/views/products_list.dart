import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../controls/providers/customer_home_provider.dart';
import '../controls/providers/favourite_provider.dart';
import '../controls/providers/shopping_card_provider.dart';
import '../modes/custom_wedgits/add_to_card_button.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    Provider.of<CustomerHomeProvider>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CustomerHomeProvider>(
        builder: (context, value, child) {
          if (value.products == null) {
            return const Center(
              child: SpinKitSpinningLines(color: Colors.white),
            );
          } else if (value.products!.isEmpty) {
            return const Center(
              child: Text('No Data Found'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.products!.length,
                itemBuilder: (context, index) {
                  final product = value.products![index];
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                product['image'].toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  product['description'].toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<FavouriteProvider>()
                                        .removeFavouriteItem(index);
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            AddToCardButton(
                              buttonText: 'ADD TO CARD',
                              onTap: () {
                                context
                                    .read<ShoppingCardProvider>()
                                    .setCardItems(
                                      index,
                                      product['image'].toString(),
                                      product['name'].toString(),
                                    );

                                Fluttertoast.showToast(
                                  msg: 'Added To Card',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
