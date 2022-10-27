import 'dart:convert';

class AllUsersModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  AllUsersModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  factory AllUsersModel.fromMap(Map<String, dynamic> map) {
    return AllUsersModel(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllUsersModel.fromJson(String source) =>
      AllUsersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
