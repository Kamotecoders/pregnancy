class Users {
  final String id;
  String name;
  String photo;
  String phone;
  final String email;
  final AccountType type;
  final DateTime createdAt; // Added field

  Users({
    required this.id,
    required this.name,
    required this.photo,
    required this.phone,
    required this.email,
    required this.type,
    required this.createdAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      type: _accountTypeFromString(json['type'] as String),
      createdAt: DateTime.parse(json['createdAt']
          as String), // Parse createdAt from String to DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'phone': phone,
      'email': email,
      'type': _accountTypeToString(type),
      'createdAt':
          createdAt.toIso8601String(), // Convert DateTime to ISO8601 String
    };
  }
}

String _accountTypeToString(AccountType type) {
  return type.toString().split('.').last;
}

AccountType _accountTypeFromString(String typeString) {
  return AccountType.values.firstWhere(
    (e) => e.toString().split('.').last == typeString,
  );
}

enum AccountType { ADMIN, USER }
