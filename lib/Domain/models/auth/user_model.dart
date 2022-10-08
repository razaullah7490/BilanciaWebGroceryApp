class UserModel {
  String email;
  String firstName;
  String lastName;
  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
    );
  }
}
