import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bump Growth Chart",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyle.primary,
      ),
      body: const Center(
        child: Text('Bump Growth Chart Page'),
      ),
    );
  }
}
