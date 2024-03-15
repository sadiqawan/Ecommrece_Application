import 'package:flutter/material.dart';

class AddToCardButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const AddToCardButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),color: Colors.black
        ),
        child:  Center(child: Text(buttonText, style: const TextStyle(color: Colors.white),)),),
    ));
  }
}
