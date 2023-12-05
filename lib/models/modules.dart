class Module {
  String id;
  final String name;
  final String url;
  final DateTime createdAt; // New field

  Module({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a Module instance from a Map (JSON)
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      createdAt: DateTime.parse(json['createdAt']), // Parse string to DateTime
    );
  }
}
