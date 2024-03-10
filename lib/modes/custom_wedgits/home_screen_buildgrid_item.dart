import 'package:flutter/material.dart';

class HomeScreenBuildGridItem extends StatelessWidget {
  final Image image;
  final String name;
  final String price;
  const HomeScreenBuildGridItem({super.key, required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image as String, height: 100),
          Text(name),
          Text(price),
        ],
      ),
    );
  }
}
