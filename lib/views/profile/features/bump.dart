import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class BumpChart extends StatelessWidget {
  const BumpChart({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bump Growth chart",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyle.primary,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0), // Added comma and semicolon here
          child: Image.asset(
            'lib/images/bump.png',
          ),
        ),
      ),
    );
  }
}
