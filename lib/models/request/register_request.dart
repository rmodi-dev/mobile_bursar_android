import 'dart:convert';

class RegisterRequest {
  RegisterRequest({
    required this.userName,
    required this.email,
    required this.password,
  });

  String userName;
  String email;
  String password;

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
      };
}
