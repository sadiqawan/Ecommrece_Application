import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesListScreen extends StatefulWidget {
  const AllCategoriesListScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoriesListScreen> createState() =>
      _AllCategoriesListScreenState();
}

class _AllCategoriesListScreenState extends State<AllCategoriesListScreen> {
  @override
  void initState() {
    Provider.of<CustomerHomeProvider>(context, listen: false).fetchBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CustomerHomeProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.brands?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                          color: Colors.black12.withOpacity(0.4),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 30.0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          value.brands![index]['image'].toString(),
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
