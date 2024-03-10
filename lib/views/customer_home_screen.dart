import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../modes/custom_wedgits/home_screen_buildgrid_item.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              child: Container(
                  color: Colors.black,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'bagzz',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
              ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
           title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
           title: Text('Contact'),
          ),
          ListTile(
            leading: Icon(Icons.email_outlined),
           title: Text('Email'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
           title: Text('LogOut'),
          ),

        ],
      )),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outlined))
        ],
        title: const Text(
          'bagzz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 340,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: GridView.builder(
          //     physics: const NeverScrollableScrollPhysics(),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 10,
          //       mainAxisSpacing: 10,
          //     ),
          //     itemCount: yourDataList.length, // Replace yourDataList with the list of data you want to display
          //     itemBuilder: (BuildContext context, int index) {
          //       // Replace HomeScreenBuildGridItem() with your widget to build individual grid items
          //       return HomeScreenBuildGridItem(data: yourDataList[index]); // You need to pass the data to your grid item widget
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
