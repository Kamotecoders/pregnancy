class Lessons {
  int id;
  String title;
  String description;

  Lessons({
    required this.id,
    required this.title,
    required this.description,
  });

  List<Lessons> getLessons() {
    return lesson1; // Access the list without the underscore
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  // Override the toString method for custom representation
  @override
  String toString() {
    return 'Lessons{id: $id, title: $title, description: $description}';
  }

  static List<Lessons> lesson1 = [
    Lessons(
      id: 1,
      title: "Musculoskeletal System",
      description:
          "During the first 2 weeks of fetal life, cartilage prototypes "
          "provide position and support. Ossification of this cartilage "
          "into bone begins at about the 12th week. Ossification con- "
          "tinues all through fetal life and actually until adulthood. "
          "Carpals, tarsals, and sternal bones generally do not ossify "
          "until birth is imminent. A fetus can be seen to move on an "
          "ultrasound as early as the 11th week, although the woman "
          "usually does not feel this movement (quickening) until "
          "almost 20 weeks of gestation.",
    ),
    Lessons(
      id: 2,
      title: "Integumentary System",
      description: "The skin of a fetus appears thin and almost translucent"
          "until subcutaneous fat begins to be deposited at about 36"
          "weeks. Skin is covered by soft downy hairs (lanugo) that"
          "serve as insulation to preserve warmth in utero and a cream"
          "cheese–like substance, vernix caseosa, which is important"
          "for lubrication and for keeping the skin from maceratingin utero.",
    ),
  ];
}
