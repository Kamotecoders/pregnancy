import 'package:flutter/material.dart';

class BabyContainer extends StatelessWidget {
  final int week;

  const BabyContainer({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/images/length.png",
              width: 24,
              height: 24,
            ),
            const Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "38.9 cm",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("Length")
          ],
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: week.toDouble() /
                      40, // Adjust based on your maximum value
                  strokeWidth:
                      8, // Adjust the stroke width to adjust the size of the indicator
                  backgroundColor: Colors
                      .grey[300], // Background color of the progress indicator
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF004643), // Color of the progress indicator
                  ),
                ),
              ),
              Image.asset(
                "lib/images/bluebaby.png",
                width: 50,
                height: 50,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/images/measure.png",
              width: 24,
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "1.3 - 1.32kg",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("Weight")
          ],
        ),
      ],
    );
  }
}
