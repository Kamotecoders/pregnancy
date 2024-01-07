import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pregnancy/models/fetal_growth.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:video_player/video_player.dart';

import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.youtube.com/watch?v=WtDknjng8TA');

class GrowthPage extends StatefulWidget {
  const GrowthPage({
    super.key,
  });

  @override
  State<GrowthPage> createState() => _GrowthPageState();
}

class _GrowthPageState extends State<GrowthPage> {
  var selectedMonth = 0;
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

            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  GrowthCard(month: pregnancyTimeline[selectedMonth]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (selectedMonth > 0)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedMonth -= 1;
                              });
                            },
                            child: const Text("Previous"),
                          ),
                        if (selectedMonth < 8)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorStyle.primary),
                            onPressed: () {
                              if (selectedMonth < 8) {
                                setState(() {
                                  selectedMonth += 1;
                                });
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("Next"),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class GrowthCard extends StatefulWidget {
  final PregnancyMonth month;
  const GrowthCard({super.key, required this.month});

  @override
  State<GrowthCard> createState() => _GrowthCardState();
}

class _GrowthCardState extends State<GrowthCard> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Replace 'assets/video.mp4' with the path to your video asset
    _videoPlayerController = VideoPlayerController.asset(widget.month.video);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 4 / 2, // Adjust the aspect ratio as needed
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Image.asset(
                widget.month.image,
              ),
              title: Text(widget.month.month),
              subtitle: Text(
                widget.month.description,
              ),
            ),
          ),
        ),
        Expanded(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _launchUrl();
            },
            child: Text.rich(
              TextSpan(
                text: 'Visit YouTube:\n',
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: _url.toString(),
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
