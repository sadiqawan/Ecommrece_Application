import 'package:flutter/material.dart';

class ProfileNameContainer extends StatelessWidget {
  final String text;
  const ProfileNameContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: Align( alignment: Alignment.centerLeft, child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
