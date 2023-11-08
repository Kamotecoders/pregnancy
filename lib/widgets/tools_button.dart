import 'package:flutter/material.dart';
import 'package:pregnancy/styles/text_styles.dart';

class ToolButtons extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ToolButtons({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor:
              Colors.white, // Set the button background color to green
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Set the button's border radius
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Adjust padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MyTextStyles.text_subheader2
                    .copyWith(color: Colors.black), // Set text color to white
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.black), // Set icon color to white
            ],
          ),
        ),
      ),
    );
  }
}
