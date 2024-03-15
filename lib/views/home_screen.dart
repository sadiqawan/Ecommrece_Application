import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommrece_application/controls/providers/favourite_provider.dart';
import 'package:ecommrece_application/views/customer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            if (index == 3) {
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
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(13.0),
          child: Consumer<FavouriteProvider>(builder: (context, value, child){
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: value.favouriteItems.length,
                  itemBuilder: (context, index){

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                // color: Colors.black,
                                height: 100,
                                width: 100,
                                child: Image.network(value.favouriteItems[index].image),

                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.favouriteItems[index].name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const    SizedBox(
                                    height: 5,
                                  ),

                                  const  Text(
                                    'Wallet with chain',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<FavouriteProvider>().removeFavouriteItem(index);
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
                                  ),


                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  }),
            );
          }),
        );
      },
    );
  }

  void cardShowBottomSheet(BuildContext context) {

    showModalBottomSheet(
      backgroundColor: Colors.black,

      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album,color: Colors.white,),
                title: Text('Option 1',style: TextStyle(color: Colors.white),),
                onTap: () => {}, // Add your functionality here
              ),
              ListTile(
                leading: Icon(Icons.album,color: Colors.white,),
                title: Text('Option 2',style: TextStyle(color: Colors.white)),
                onTap: () => {}, // Add your functionality here
              ),
            ],
          ),
        );
      },
    );
  }
}
