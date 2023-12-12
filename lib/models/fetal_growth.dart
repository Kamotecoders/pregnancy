class PregnancyMonth {
  String month;
  String image;
  String video;
  String description;

  PregnancyMonth({
    required this.month,
    required this.image,
    required this.video,
    required this.description,
  });

  factory PregnancyMonth.fromJson(Map<String, dynamic> json) {
    return PregnancyMonth(
      month: json['month'],
      image: json['image'],
      video: json['video'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "month": month,
      "image": image,
      "video": video,
      "description": description,
    };
  }
}
