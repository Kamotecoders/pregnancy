class Developer {
  final String name;
  final String image;
  final String role;
  final String description;

  Developer({
    required this.name,
    required this.image,
    required this.role,
    required this.description,
  });

  // Convert the Developer object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'role': role,
      'description': description,
    };
  }

  // Create a Developer object from a JSON map
  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      name: json['name'],
      image: json['image'],
      role: json['role'],
      description: json['description'],
    );
  }
  static final List<Developer> developers = [
    Developer(
        name: 'Lester James L. Sayco',
        image: 'lib/images/developer.jpg',
        role: 'Mobile App Developer',
        description:
            'Experienced mobile app developer with a passion for creating '
            'user-friendly and efficient applications. Skilled in Flutter, '
            'Android, and iOS app development.'),
    Developer(
      name: 'Christian Jaycon R. Dona',
      image: 'lib/images/developer.jpg',
      role: 'Backend Developer',
      description:
          'Backend developer with a focus on server-side programming and '
          'building scalable and robust APIs. Proficient in Firebase and Node.js. ',
    ),
    Developer(
      name: 'Guibz M. Gadon',
      image: 'lib/images/developer.jpg',
      role: 'UI / UX Designer',
      description:
          'Creative UI/UX designer with a keen eye for user-centered design. '
          'Passionate about creating intuitive and visually appealing user interfaces.',
    ),
    Developer(
        name: 'Joan R. Mangupit',
        image: 'lib/images/developer.jpg',
        role: 'Documentation Specialist',
        description:
            'I make ensure our projects have clear and organized documentation,  making collaboration more efficient and helping clients understand our work better.'),
  ];
}
