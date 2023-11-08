import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/widgets/tools_button.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tools",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          backgroundColor: ColorStyle.primary,
        ),
        body: Column(
          children: [
            ToolButtons(
              title: "Is it safe ?",
              onTap: () {},
            ),
            ToolButtons(
              title: "Weight Gain Chart ",
              onTap: () {},
            ),
            ToolButtons(
              title: "Bump Growth Chart ",
              onTap: () {},
            ),
            ToolButtons(
              title: "Names ",
              onTap: () {},
            )
          ],
        ));
  }
}
