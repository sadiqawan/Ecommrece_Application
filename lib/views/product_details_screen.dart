import 'package:ecommrece_application/modes/custom_wedgits/add_to_card_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../controls/providers/shopping_card_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String name;
  final String price, description;
  final index ;


  const ProductDetailsScreen({
    super.key,
    required this.image,
    required this.price,
    required this.description, required this.name,
    required this.index,
  });




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.network(image ), // Use Image.network directly with the provided image URL
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(' Price \$ $price', style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20
                    ),
                    ),
                  const  SizedBox(width: 30,),

                    AddToCardButton(

                        onTap: () {
                          context
                              .read<ShoppingCardProvider>()
                              .setCardItems(index, image, name, price);

                          Fluttertoast.showToast(
                            msg: 'Added To Card',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        buttonText: 'AddToCard')
        
        
                  ],
                ),
                const SizedBox(
                  height: 25
                ),
                const Text('Details',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),),
                const SizedBox(
                  height: 15,
                ),
                Text(description, style: const TextStyle(fontSize: 18, ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
