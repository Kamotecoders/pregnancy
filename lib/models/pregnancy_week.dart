class PregnancyWeek {
  final int weekNumber;
  final String description;
  final String image;
  final int? dayOfWeekDifference;

  PregnancyWeek({
    required this.weekNumber,
    required this.description,
    required this.image,
    this.dayOfWeekDifference,
  });

  factory PregnancyWeek.fromJson(Map<String, dynamic> json) {
    return PregnancyWeek(
      weekNumber: json['weekNumber'] as int,
      description: json['description'] as String,
      image: json['image'] as String,
      dayOfWeekDifference: json['dayOfWeekDifference'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'description': description,
      'image': image,
      'dayOfWeekDifference': dayOfWeekDifference,
    };
  }
}
