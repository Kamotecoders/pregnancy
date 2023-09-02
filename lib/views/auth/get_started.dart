import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pregnancy/app_router.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  "lib/images/baby.png",
                  height: 150,
                  width: 150,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Bringing Preganancy to life Development of Mobile Application for Fetal Growth',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: ColorStyle.text_primary, // Optional: Text color
                    ),
                    textAlign: TextAlign.center,
                    textDirection:
                        TextDirection.ltr, // Set text direction if needed
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              height: 339.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'lib/images/bg.png',
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Text(
                      'Watch your baby grow, log your symptoms and learn what to expect week by week with Growly Pregnancy!',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        color: ColorStyle.text_primary,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Clicked");
                      context.push("/login");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xff89d2c4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Center(
                          child: Text(
                            'Get Started',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
