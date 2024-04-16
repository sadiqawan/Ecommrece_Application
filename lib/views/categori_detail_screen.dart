import 'package:flutter/material.dart';

class CategoriesDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String description;

  const CategoriesDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.description,
  });

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: const Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    radius: 150,
                  ),
                ),

                // Image.network(
                //   // Accessing image from the widget's properties
                //   height: 300, // Adjust height as needed
                //   width: 300, // Adjust width as needed
                // ),
                const SizedBox(height: 15),
                Text(
                  widget.name, // Accessing name from the widget's properties
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
               const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.description, // Accessing description from the widget's properties
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
