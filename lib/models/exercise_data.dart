class Exercises {
  final String name;
  final String image;
  final String description;
  final String duration;
  final String frequency;

  Exercises({
    required this.name,
    required this.image,
    required this.description,
    required this.duration,
    required this.frequency,
  });

  factory Exercises.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final image = json['image'];
    final description = json['description'];
    final duration = json['duration'];
    final frequency = json['frequency'];

    return Exercises(
      name: name,
      image: image,
      description: description,
      duration: duration,
      frequency: frequency,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'frequency': frequency,
    };
  }
}
