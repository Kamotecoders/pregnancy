import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pregnancy/blocs/module/module_bloc.dart';
import 'package:pregnancy/repositories/file_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/views/admin/admin.dart';
import 'package:pregnancy/views/calendar/calendar.dart';
import 'package:pregnancy/views/exercise/exercise.dart';
import 'package:pregnancy/views/home/home.dart';
import 'package:pregnancy/views/profile/profile.dart';
import 'package:pregnancy/views/weight/weight_tracker.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: FutureBuilder<Users?>(
        future: context.read<UserRepository>().getUserProfile(
            context.read<AuthRepository>().currentUser?.uid ??
                ""), // Replace 'userId' with the actual user ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final user = snapshot.data;

              if (user != null) {
                final Users users = user;
                if (users.type == AccountType.ADMIN) {
                  return BlocProvider(
                    create: (context) => ModuleBloc(
                        fileRepository: context.read<FileRepository>()),
                    child: const AdminBottomNav(),
                  );
                } else {
                  return const UserBottomNav();
                }
              } else {
                return const Center(child: Text('User not found'));
              }
            }
          }
        },
      ),
    );
  }
}

class UserBottomNav extends StatefulWidget {
  const UserBottomNav({super.key});

  @override
  State<UserBottomNav> createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> {
  int _selectedIndex = 0;
  static const List<String> _titles = [
    "Home",
    "Exercise",
    "Calendar",
    "Developers",
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
              Icons.developer_mode_sharp,
              size: 24.0,
              semanticLabel: 'Text to weight tracker',
            ),
            label: 'Developers',
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

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _selectedIndex = 0;
  static const List<String> _titles = ["Administrator", "Profile"];
  static const List<Widget> _pages = <Widget>[
    AdminHomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<File?> pickAndReadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
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
            label: 'Administrator',
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
      body: BlocConsumer<ModuleBloc, ModuleState>(
        listener: (context, state) {
          if (state is ModuleErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ModuleSuccessState<String>) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Success")));
          }
        },
        builder: (context, state) {
          return state is ModuleLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _pages[_selectedIndex];
        },
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                File? result = await pickAndReadPdf();
                if (result != null) {
                  context.read<ModuleBloc>().add(UploadFileEvent(result));
                }
              },
              backgroundColor: ColorStyle.primary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
