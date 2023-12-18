import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/utils/constants.dart';
import 'package:pregnancy/widgets/features_card.dart';
import 'package:pregnancy/widgets/profile.dart';

import '../../models/user.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';

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
          UserProfileSection(),
          const FeaturesContainer(),
        ],
      ),
    );
  }
}

class DynamicBaby extends StatelessWidget {
  final DateTime createdAt;
  DynamicBaby({super.key, required this.createdAt});

  List<String> _imageUrls = [];

  //dito malalaman kung ilang week na ba yung account
  int whatWeek(DateTime createdAt) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(createdAt);
    int weeks = (difference.inDays / 7).floor();
    return weeks;
  }

  int whatDayOfTheWeek(DateTime createdAt) {
    DateTime currentDate = DateTime.now();
    final day = currentDate.weekday;
    // Duration difference = currentDate.difference(createdAt);
    // int days = difference.inDays;
    // int dayOfWeek = (days % 7); // 0 for Sunday, 1 for Monday, and so on
    return day;
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF3EB09B),
        image: const DecorationImage(
            image: AssetImage('lib/images/week_2.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Week ${whatWeek(createdAt) + 1}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Day ${whatDayOfTheWeek(createdAt)}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: context.read<UserRepository>().getUserProfile(
          context.read<AuthRepository>().currentUser?.uid ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found.'));
        } else {
          Users user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello,',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${user.name}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: Image.network(
                          user.photo,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                DynamicBaby(createdAt: user.createdAt)
                // Add more fields as needed
              ],
            ),
          );
        }
      },
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
