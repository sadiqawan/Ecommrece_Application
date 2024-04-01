import 'package:ecommrece_application/modes/custom_wedgits/add_to_card_button.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String price, description;

  const ProductDetailsScreen({
    Key? key,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

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
                    AddToCardButton(onTap: (){}, buttonText: 'AddToCard')
        
        
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
