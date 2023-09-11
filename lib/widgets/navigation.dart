import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/views/calendar/calendar.dart';
import 'package:pregnancy/views/exercise/exercise.dart';
import 'package:pregnancy/views/home/home.dart';
import 'package:pregnancy/views/profile/profile.dart';
import 'package:pregnancy/views/weight/weight_tracker.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  static const List<String> _titles = [
    "Home",
    "Exercise",
    "Calendar",
    "Weight Tracker",
    "Profile"
  ];
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ExercisePage(),
    CalendarPage(),
    WeightTrackerPage(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyle.primary,
      ),
      drawer: const Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorStyle.primary,
        unselectedItemColor: ColorStyle.blackColor,
        showSelectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24.0,
              semanticLabel: 'Text to home',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.run_circle_outlined,
              size: 24.0,
              semanticLabel: 'Text to exercise',
            ),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_outlined,
              size: 24.0,
              semanticLabel: 'Text to calendar',
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monitor_weight_outlined,
              size: 24.0,
              semanticLabel: 'Text to weight tracker',
            ),
            label: 'Weight',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              size: 24.0,
              semanticLabel: 'Text to profile',
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
