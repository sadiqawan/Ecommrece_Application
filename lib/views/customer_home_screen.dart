import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/controls/providers/favourite_provider.dart';
import 'package:ecommrece_application/modes/custom_wedgits/custom_button.dart';
import 'package:ecommrece_application/views/all_categries_list_screen.dart';
import 'package:ecommrece_application/views/categori_detail_screen.dart';

import 'package:ecommrece_application/views/products_list_screen.dart';
import 'package:ecommrece_application/views/shopp_now_screen.dart';
import 'package:ecommrece_application/views/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../controls/providers/shopping_card_provider.dart';
import '../modes/custom_wedgits/custom_drawer.dart';
import 'product_details_screen.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 1000), child: const UserProfileScreen()));
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => const UserProfileScreen()),
                // );
              },
              icon: const Icon(
                Icons.person,
                size: 45,
              )),
          const SizedBox(
            width: 10,
          )
        ],
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
                    return const SpinKitSpinningLines(
                        color: Colors
                            .white); // Return empty container if no products
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.black12),
                                    child: Image.network(
                                      promo['image'],
                                    ),
                                  ),
                                  Positioned(
                                    top: 150,
                                    bottom: 10,
                                    right: 0,
                                    child: Text(
                                      ' ${promo['discreption'].toString()}',
                                      maxLines: 2,
                                      style: const TextStyle(
                                        backgroundColor: Colors.black,
                                        color: Colors.white,
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
                        ));
                  }
                },
              ),
              const Gap(20),

              // Carousel Slider for product images
              Consumer<CustomerHomeProvider>(
                builder: (context, value, child) {
                  if (value.products == null || value.products!.isEmpty) {
                    return const SpinKitSpinningLines(
                        color: Colors
                            .white); // Return empty container if no products
                  } else {
                    return CarouselSlider(
                      items: value.products!.map((product) {
                        int index = value.products!.indexOf(
                            product); // Get the index of the current product
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                  duration: const Duration(milliseconds: 600),
                                  type: PageTransitionType.leftToRight,
                                  child:  ProductDetailsScreen(
                                    image: product['image'],
                                    price: product['price'].toString(),
                                              description: product['discreption'],
                                          name: product['name'],
                                          index: index,
                                  ),
                                ));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ProductDetailsScreen(
                                //           image: product['image'],
                                //           price: product['price'].toString(),
                                //           description: product['discreption'],
                                //       name: product['name'],
                                //       index: index,
                                //         ),
                                // ),
                                // );
                              },
                              child: Container(
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
                                    const SizedBox(height: 8),
                                    Text(
                                      ' ${product['name'].toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<ShoppingCardProvider>()
                                            .setCardItems(
                                              index, // Use the index obtained above
                                              product['image'],
                                              product['name'].toString(),
                                              product['price'].toString(),
                                            );
                                        Navigator.of(context).push(
                                            PageTransition(
                                              duration: const Duration(milliseconds: 800),
                                              type: PageTransitionType.leftToRight,
                                              child: const ShoppNow(),
                                            ));
                                      },
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

              Consumer<CustomerHomeProvider>(
                builder: (context, provider, child) {
                  if (provider.products == null) {
                    return const Center(
                      child: SpinKitSpinningLines(color: Colors.black),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = provider.products![index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                        image: product['image'],
                                        price: product['price'].toString(),
                                        description: product['discreption'],
                                        name: product['name'],
                                    index: index,

                                      )));
                            },
                            child: Center(
                              child: Stack(
                                children: [
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
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Consumer<FavouriteProvider>(
                                      builder: (context, value, child) {
                                        return IconButton(
                                          onPressed: () {
                                            if (value.favouriteItems.any(
                                                (item) =>
                                                    item.index == index)) {
                                              context
                                                  .read<FavouriteProvider>()
                                                  .removeFavouriteItem(index);
                                            } else {
                                              // Ensure to pass the correct image and name parameters
                                              context
                                                  .read<FavouriteProvider>()
                                                  .setFavouriteItem(
                                                      index,
                                                      product['image'],
                                                      product['name'],
                                                      product['price']
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            value.favouriteItems.any((item) =>
                                                    item.index == index)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: value.favouriteItems.any(
                                                    (item) =>
                                                        item.index == index)
                                                ? Colors.black
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                        duration: const Duration(milliseconds: 600),
                        type: PageTransitionType.bottomToTop,
                        child: const ProductsListScreen(),
                      ));

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const ProductsListScreen()));
                    }),
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
                        itemCount: 4 ,
                        // value.brands!.length
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
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoriesDetailScreen(
                                                  image:
                                                      brand['image'].toString(),
                                                  name:
                                                      brand['name'].toString(),
                                                  description: '',
                                                ),
                                        ),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.black12,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(brand['image']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
              Consumer<CustomerHomeProvider>(builder: (context, value, child){
                 return Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: CustomButton(
                       text: 'BROWSE ALL CATEGORIES',
                       textStyle: const TextStyle(fontWeight: FontWeight.bold),
                       onTap: () {
                         Navigator.of(context).push(
                             PageTransition(
                           duration: const Duration(milliseconds: 600),
                           type: PageTransitionType.bottomToTop,
                           child: const AllCategoriesListScreen(),
                         ));
                         // Navigator.of(context).push(MaterialPageRoute(
                         //     builder: (context) =>
                         //     const AllCategoriesListScreen()));
                       }),
                 );
               }),
               const Gap(15),

              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
