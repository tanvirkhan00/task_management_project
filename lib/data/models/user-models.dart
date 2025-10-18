

class UserModel{
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobile;
  final String photo;

  String get FullName {
    return '$firstname $lastname';
  }

  UserModel({required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['_id'],
        email: jsonData['email'],
        firstname: jsonData['firstName'],
        lastname: jsonData['lastName'],
        mobile: jsonData['mobile'],
        photo: jsonData['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'email' : email,
      'firstname' : firstname,
      'lastname' : lastname,
      'mobile' : mobile,
      'photo' : photo,
    };
  }

}