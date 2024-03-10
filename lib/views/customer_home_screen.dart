import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modes/custom_wedgits/custom_drawer.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch product data when the screen initializes
    Provider.of<CustomerHomeProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Home'),
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Carousel Slider for product images
          Consumer<CustomerHomeProvider>(
            builder: (context, value, child) {
              if (value.products == null || value.products!.isEmpty) {
                return const SizedBox(); // Return empty container if no products
              } else {
                return CarouselSlider(
                  items: value.products!.map((product) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(color: Colors.black12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(product['image'],height: 120,),
                              Text('\$: ${product['price'].toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              TextButton(onPressed: (){}, child: Text('SHOPE NOW'))
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 250,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  ),
                );
              }
            },
          ),
          // List of products
          // Expanded(
          //   child: Consumer<CustomerHomeProvider>(
          //     builder: (context, provider, child) {
          //       if (provider.products == null) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         ); // Show loading indicator while fetching data
          //       } else if (provider.products!.isEmpty) {
          //         return const Center(
          //           child: Text('No products found'),
          //         ); // Show message if there are no products
          //       } else {
          //         return ListView.builder(
          //           itemCount: provider.products!.length,
          //           itemBuilder: (context, index) {
          //             final product = provider.products![index];
          //             return ListTile(
          //               title: Text(product['name']),
          //               subtitle: Text(product['description']),
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
