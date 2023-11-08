import 'package:flutter/material.dart';

class FeaturesCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const FeaturesCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 88),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
