import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/controls/providers/favourite_provider.dart';
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

class CustomerFavoriteScreen extends StatefulWidget {
  const CustomerFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<CustomerFavoriteScreen> createState() => _CustomerFavoriteScreenState();
}

class _CustomerFavoriteScreenState extends State<CustomerFavoriteScreen> {
  @override


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
          child: Consumer<FavouriteProvider>(builder: (context, value, child){
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: value.favouriteItems.length,
                  itemBuilder: (context, index){

                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          // color: Colors.black,
                          height: 100,
                          width: 100,
                          child: Text(index.toString()),
              
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'title',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'subtitle',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'explain',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextButton(
                              onPressed: () {},
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
                      ],
                    )
                  ],
                );
              }),
            );
          })
        ),
      ),
    );
  }
}
