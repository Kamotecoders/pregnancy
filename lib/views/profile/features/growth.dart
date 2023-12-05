import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pregnancy/models/fetal_growth.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key,});

  @override
  Widget build(BuildContext context) {
    Future<List<PregnancyMonth>> loadJsonData() async {
      try {
        final jsonString =
        await rootBundle.loadString('lib/assets/data/pregnant.json');
        print(jsonString);
        final List<dynamic> jsonList = json.decode(jsonString);

        return jsonList.map((json) => PregnancyMonth.fromJson(json)).toList();
      } catch (e) {

        print('Error loading JSON: $e');
        return []; // Return an empty list or handle the error as needed
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fetal Growth Stage Development",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyle.primary,
      ),
      body: FutureBuilder<List<PregnancyMonth>>(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            // Successfully loaded data
            List<PregnancyMonth> pregnancyTimeline = snapshot.data!;

            return ListView.builder(
              itemCount: pregnancyTimeline.length,
              itemBuilder: (context, index) {
                PregnancyMonth month = pregnancyTimeline[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  color: Color(0xFF3EB09B).withOpacity(0.4), // Set a fallback color with 40% opacity
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, // Adjust the gradient direction
                        end: Alignment.bottomCenter, // Adjust the gradient direction
                        colors: [
                          Color(0xFF3EB09B).withOpacity(0.4), // Adjust the opacity
                          Color(0xFF3EB09B).withOpacity(0.4), // Adjust the opacity
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(month.image),
                      title: Text(
                        month.month,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        month.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );

              },
            );
          }
        },
      ),
    );
  }


}

