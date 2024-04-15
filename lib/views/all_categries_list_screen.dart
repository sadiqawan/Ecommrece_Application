import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllCategoriesListScreen extends StatefulWidget {
  const AllCategoriesListScreen({super.key});

  @override
  State<AllCategoriesListScreen> createState() => _AllCategoriesListScreenState();
}

class _AllCategoriesListScreenState extends State<AllCategoriesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],

                color: Colors.pink
              ),
            ),
          )
        ],
      ),
    );
  }
}
