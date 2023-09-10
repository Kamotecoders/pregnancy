import 'package:flutter/material.dart';

class ProfileImageWithButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final double size;
  ProfileImageWithButton(
      {required this.imageUrl, required this.onTap, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: CircleAvatar(
        radius: 50, // Adjust the size as needed
        backgroundColor: Colors.grey[300], // Placeholder background color
        child: ClipOval(
          child: imageUrl.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 80, // Size of the icon
                  color: Colors.grey, // Placeholder icon color
                )
              : Image.network(
                  imageUrl,
                  width: size, // Width of the image
                  height: size, // Height of the image
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
        ),
      ),
    );
  }
}
