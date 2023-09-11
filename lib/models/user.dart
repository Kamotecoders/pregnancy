class Users {
  final String id;
  String name;
  final String photo;
  String phone;
  final String email;

  Users({
    required this.id,
    required this.name,
    required this.photo,
    required this.phone,
    required this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'phone': phone,
      'email': email,
    };
  }
}
