import 'package:flutter/material.dart';

class ProfileImageWithButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final double size;
  ProfileImageWithButton(
      {required this.imageUrl, required this.onTap, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[300],
        child: ClipOval(
          child: imageUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: size,
                  color: Colors.grey,
                )
              : Image.network(
                  imageUrl,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
