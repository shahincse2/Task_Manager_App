class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      mobile: jsonData['mobile'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
