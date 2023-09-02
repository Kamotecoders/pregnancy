import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregnancy app'),
        backgroundColor: ColorStyle.primary,
      ),
      drawer: const Drawer(),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
