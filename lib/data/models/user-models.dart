class UserModel {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobile;
  final String photo;

  String get fullName => '$firstname $lastname';

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.photo, required String firstName, required String lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'] ?? jsonData['id'] ?? '',
      email: jsonData['email'] ?? '',
      firstname: jsonData['firstName'] ?? jsonData['firstname'] ?? '',
      lastname: jsonData['lastName'] ?? jsonData['lastname'] ?? '',
      mobile: jsonData['mobile'] ?? '',
      photo: jsonData['photo'] ?? '', firstName: '', lastName: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'mobile': mobile,
      'photo': photo,
    };
  }
}
