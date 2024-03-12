import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/modes/custom_wedgits/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    // Fetch brands data when the screen initializes
    Provider.of<CustomerHomeProvider>(context, listen: false).fetchBrands();
    // Fetch promo data when the screen initializes
    Provider.of<CustomerHomeProvider>(context, listen: false).fetchPromo();

  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [

              Consumer<CustomerHomeProvider>(
                builder: (context, value, child) {
                  if (value.promo == null || value.promo!.isEmpty) {
                    return const SpinKitSpinningLines(color: Colors.white); // Return empty container if no products
                  } else {
                    return CarouselSlider(
                      items: value.promo!.map((promo) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:
                                  const BoxDecoration(color: Colors.black12),
                                  child: Image.network(
                                    promo['image'],
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  bottom: 10,
                                  child:  Text(
                                  ' ${promo['discreption'].toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                ),


                              ],
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        initialPage: 0,
                        reverse: false,
                        autoPlay: true,
                      )
                      );
                  }
                },
              ),
              Gap(20),


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
                      child: SpinKitSpinningLines(color: Colors.white),
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
              const Gap(20),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                    text: 'CHECK ALL LATEST',
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    onTap: () {}),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Shop by categories',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white24,
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                        fontFamily: GoogleFonts.playfairDisplay.toString()),
                  ),
                ),
              ),
              const Gap(10),

              Consumer<CustomerHomeProvider>(
                builder: (context, value, child) {
                  if (value.brands == null) {
                    return const Center(
                      child: SpinKitSpinningLines(color: Colors.white),
                    );
                  } else if (value.brands!.isEmpty) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.brands!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final brand = value.brands![index];
                          return Center(
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(brand['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      brand['name'].toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                    text: 'BROWSE ALL CATEGORIES',
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    onTap: () {}),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
