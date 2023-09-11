import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/views/exercise/exercise_card.dart';
import 'package:pregnancy/views/exercise/exercise_card_list.dart';

import '../../models/excercise_planner.dart';
import '../../models/exercise_data.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with SingleTickerProviderStateMixin {
  List<Widget> tabViews = [];
  late TabController _tabController;

  Future<List<ExercisePlanner>> loadJsonData() async {
    try {
      final jsonString =
          await rootBundle.loadString('lib/assets/data/exercises.json');

      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((json) => ExercisePlanner.fromJson(json)).toList();
    } catch (e) {
      print('Error loading JSON: $e');
      return []; // Return an empty list or handle the error as needed
    }
  }

  List<Exercises> getExercisesPerTrimester(
      String trimester, List<ExercisePlanner> planner) {
    List<Exercises> filteredList = [];

    for (var item in planner) {
      if (item.trimester.toLowerCase() == trimester.toLowerCase()) {
        filteredList.addAll(item.exercises);
      }
    }

    return filteredList;
  }

  Set<String> getTrimesters(List<ExercisePlanner> planners) {
    Set<String> filteredItemNames = {};

    for (var item in planners) {
      item.trimester.toLowerCase();
      filteredItemNames.add(item.trimester);
    }
    return filteredItemNames;
  }

  void generateTabViews(
      List<String> categories, List<ExercisePlanner> planners) {
    for (String category in categories) {
      tabViews.add(ExerciseCardList(
          exerciseDataList: getExercisesPerTrimester(category, planners)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final exercisePlannerList = snapshot.data ?? [];
          List<String> trimesters = getTrimesters(exercisePlannerList).toList();

          _tabController =
              TabController(length: trimesters.length, vsync: this);
          generateTabViews(trimesters, exercisePlannerList);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                    labelColor: ColorStyle.primary,
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorWeight: 2,
                    labelStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    tabs: exercisePlannerList
                        .map((e) => Tab(
                              text: e.trimester,
                            ))
                        .toList()),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabViews,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
