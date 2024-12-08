// FILE: user_model.dart

class UserModel{
  final String id;
  final String username;
  final String email;
  final String createdAt;
  final String birthdate;
  final String gender;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.birthdate,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? 'User',
      email: json['email'] ?? '',
      createdAt: json['created_at'] ?? '',
      birthdate: json['birth_date'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'created_at': createdAt,
      'birth_date': birthdate,
      'gender': gender,
    };
  }
}