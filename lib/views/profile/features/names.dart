import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class Names extends StatelessWidget {
  const Names({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> girls = [
      {'id': '1', 'name': 'Catherine', 'meaning': 'pure'},
      {'id': '2', 'name': 'Elizabeth', 'meaning': 'God is my oath'},
      {'id': '3', 'name': 'Diana', 'meaning': 'divine'},
      {'id': '4', 'name': 'Anastasia', 'meaning': 'resurrection'},
      {'id': '5', 'name': 'Beatrice', 'meaning': 'blessed'},
      {'id': '6', 'name': 'Rachel', 'meaning': 'ewe'},
      {'id': '7', 'name': 'Maria', 'meaning': 'Mariam'},
      {'id': '8', 'name': 'Mia', 'meaning': 'beauty'},
      {'id': '9', 'name': 'Julia', 'meaning': 'dedicated to Jupiter'},
      {
        'id': '10',
        'name': 'Mackenzie',
        'meaning': 'born of fire or child of the wise leader'
      },
      {'id': '11', 'name': 'Phoebe', 'meaning': 'radiant or shining one'},
      {'id': '12', 'name': 'Victoria', 'meaning': 'victory'},
    ];

    List<Map<String, String>> boys = [
      {'id': '1', 'name': 'Sebastian', 'meaning': 'from Sebaste'},
      {'id': '2', 'name': 'Mateo', 'meaning': 'gift of Yahweh'},
      {'id': '3', 'name': 'Ezra', 'meaning': 'help'},
      {'id': '4', 'name': 'Elias', 'meaning': 'my God is Yahweh'},
      {'id': '5', 'name': 'Silas', 'meaning': 'wood forest'},
      {'id': '6', 'name': 'Waylen', 'meaning': 'a skilled craftsman'},
      {'id': '7', 'name': 'Rowan', 'meaning': 'red'},
      {'id': '8', 'name': 'Amir', 'meaning': 'prince'},
      {'id': '9', 'name': 'Thiago', 'meaning': 'may God protect'},
      {'id': '10', 'name': 'Adan', 'meaning': 'man'},
      {'id': '11', 'name': 'Bradford', 'meaning': 'broad ford'},
      {'id': '12', 'name': 'Kendric', 'meaning': 'royal ruler'},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.face_6),
                text: "Boy",
              ),
              Tab(
                icon: Icon(Icons.face_2_sharp),
                text: "Girl",
              ),
            ],
          ),
          title: const Text(
            "Names",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          backgroundColor: ColorStyle.primary,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Card(
                elevation: 5, // Increased elevation
                margin: const EdgeInsets.all(16), // Added margin
                color: Colors.white, // Set white background
                child: Column(
                  children: boys.map((name) {
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text('${name['id']}. ${name['name']}'),
                      subtitle: Text('Meaning: ${name['meaning'] ?? ''}'),
                    );
                  }).toList(),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Card(
                elevation: 5, // Increased elevation
                margin: const EdgeInsets.all(16), // Added margin
                color: Colors.white, // Set white background
                child: Column(
                  children: girls.map((name) {
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text('${name['id']}. ${name['name']}'),
                      subtitle: Text('Meaning: ${name['meaning'] ?? ''}'),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
