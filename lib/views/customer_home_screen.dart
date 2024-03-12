import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/modes/custom_wedgits/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration:
                                  const BoxDecoration(color: Colors.black12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    product['image'],
                                    height: 120,
                                  ),
                                  const Gap(8),
                                  Text(
                                    ' ${product['name'].toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const Gap(5),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'SHOP NOW',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
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
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      ),
                    );
                  }
                },
              ),
              const Gap(20),

              // Add some space between Carousel Slider and GridView
              Consumer<CustomerHomeProvider>(
                builder: (context, provider, child) {
                  if (provider.products == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show loading indicator while fetching data
                  } else if (provider.products!.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    ); // Show message if there are no products
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        // Ensure GridView takes only required space
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable GridView's scrolling
                        itemCount: provider.products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          // Adjust as per your preference
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = provider.products![index];
                          return Center(
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 100,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border)),
                                ),
                                Container(
                                  color: Colors.black12,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        product['image'],
                                        height: 120,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            ' ${product['name'].toString()}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
              const Gap(15),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                    text: 'CHECK ALL LATEST',
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    onTap: () {}),
              ),
              const Gap(15),
              Padding(
                padding:  const EdgeInsets.all(15.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Shop by categories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: GoogleFonts.playfairDisplay.toString()
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
