class UserModel {
  String email;
  String password;

  UserModel({
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
