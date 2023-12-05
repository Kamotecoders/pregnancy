

class PregnancyMonth {
  String month;
  String image;
  String description;

  PregnancyMonth({
    required this.month,
    required this.image,
    required this.description,
  });

  factory PregnancyMonth.fromJson(Map<String, dynamic> json) {
    return PregnancyMonth(
      month: json['month'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "month": month,
      "image": image,
      "description": description,
    };
  }
}