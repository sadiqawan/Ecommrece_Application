import 'package:ecommrece_application/controls/providers/customer_home_provider.dart';
import 'package:ecommrece_application/views/categori_detail_screen.dart';
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoriesDetailScreen(
                            image: value.brands![index]['image'],
                            name: value.brands![index]['name'],
                            description: ''
                            // value.brands![index]['description']
                        )));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Change this color to your preference
                                    spreadRadius: 12,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.black12.withOpacity(0.4),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Positioned.fill(
                        bottom: 40.0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.network(
                            value.brands![index]['image'].toString(),
                            height: 200,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        left: 0,
                        right: 0,
                        child: Text(
                          value.brands![index]['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
