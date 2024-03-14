import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommrece_application/views/customer_home_screen.dart';
import 'package:flutter/material.dart';
import 'customer_favourite_screen.dart';
import 'customer_search_screen.dart';
import 'customer_shopping_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    const CustomerHomeScreen(),
    const CustomerSearchScreen(),
    const CustomerFavoriteScreen(),
    const CustomerShoppingScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        index: _currentIndex,
        backgroundColor: Colors.white,
        items: const [
          Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 2) {
              // If favorite icon is clicked
              favouriteShowBottomSheet(context);
            }
          });
          setState(() {
            _currentIndex = index;
            if (index == 4) {
              // If favorite icon is clicked
              cardShowBottomSheet(context);
            }
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }

  void favouriteShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text('Option 1'),
                onTap: () => {}, // Add your functionality here
              ),
              ListTile(
                leading: Icon(Icons.album),
                title: Text('Option 2'),
                onTap: () => {}, // Add your functionality here
              ),
            ],
          ),
        );
      },
    );
  }
  void cardShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text('items no 1'),
                onTap: () => {}, // Add your functionality here
              ),
              ListTile(
                leading: Icon(Icons.album),
                title: Text('Item No 2'),
                onTap: () => {}, // Add your functionality here
              ),
            ],
          ),
        );
      },
    );
  }
}
