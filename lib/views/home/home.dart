import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/utils/constants.dart';
import 'package:pregnancy/widgets/features_card.dart';
import 'package:pregnancy/widgets/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DynamicBaby(),
          const FeaturesContainer(),
        ],
      ),
    );
  }
}

class DynamicBaby extends StatelessWidget {
  DynamicBaby({super.key});

  List<String> _imageUrls = [];

  //dito malalaman kung ilang week na ba yung account
  int whatWeek(DateTime createdAt) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(createdAt);
    int weeks = (difference.inDays / 7).floor();
    return weeks;
  }

  //eto nirereturn nya yung image url kung ano image ang ididisplay
  String getImageToDisplay(int week) {
    if (week > 42) {
      return "Default Image";
    }
    return _imageUrls[week];
  }

  String getDateToday() {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(currentDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF3EB09B),
        image: const DecorationImage(
            image: AssetImage('lib/images/week_2.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getDateToday(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Week 42",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Day 6",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesContainer extends StatelessWidget {
  const FeaturesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      children: <Widget>[
        FeaturesCard(
          image: "lib/images/lesson.png",
          title: "Lesson",
          onTap: () => context.push('/lesson'),
        ),
        FeaturesCard(
          image: "lib/images/assessment.png",
          title: "Assessment",
          onTap: () => context.push('/assessment'),
        ),
        FeaturesCard(
          image: "lib/images/growth.png",
          title: "Fetal Growth  Development",
          onTap: () => context.push('/growth'),
        ),
        FeaturesCard(
          image: "lib/images/tools.png",
          title: "Tools",
          onTap: () => context.push('/tools'),
        ),
      ],
    );
  }
}
