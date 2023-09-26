import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pregnancy/utils/constants.dart';
import 'package:pregnancy/widgets/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreeting(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  const Text(
                    "John Doe",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileImageWithButton(
                imageUrl: "",
                onTap: () {},
                size: 50.0,
              ),
            ),
          ],
        ),
        Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius:
                BorderRadius.circular(10), // Add a 10-pixel border radius
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("lib/images/coloredbaby.png"),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Week 2",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "Day 6",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            shrinkWrap: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius:
                      BorderRadius.circular(10), // Add a 10-pixel border radius
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'lib/assets/svg/book.svg',
                          semanticsLabel: 'A red up arrow',
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const Text(
                        "Lesson",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius:
                      BorderRadius.circular(10), // Add a 10-pixel border radius
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'lib/assets/svg/question.svg',
                          semanticsLabel: 'A red up arrow',
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const Text(
                        "My Questions?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius:
                      BorderRadius.circular(10), // Add a 10-pixel border radius
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'lib/assets/svg/sample.svg',
                          semanticsLabel: 'A red up arrow',
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const Text(
                        "Sample",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius:
                      BorderRadius.circular(10), // Add a 10-pixel border radius
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'lib/assets/svg/water.svg',
                          semanticsLabel: 'A red up arrow',
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const Text(
                        "Water Reminder",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
