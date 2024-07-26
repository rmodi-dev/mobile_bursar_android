// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

class UsersResponse {
  UsersResponse({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.currentClass,
    required this.gender,
    required this.physicalAddress,
  });

  String studentId;
  String firstName;
  String lastName;
  String currentClass;
  String gender;
  String physicalAddress;

  factory UsersResponse.fromRawJson(String str) =>
      UsersResponse.fromJson(json.decode(str));

  set value(UsersResponse value) {}

  String toRawJson() => json.encode(toJson());

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        studentId: json["studentId"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        currentClass: json["currentClass"] ?? '',
        gender: json["gender"] ?? '',
        physicalAddress: json["physicalAddress"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "firstName": firstName,
        "lastName": lastName,
        "currentClass": currentClass,
        "gender": gender,
        "physicalAddress": physicalAddress,
      };

  void refresh() {}
}

class Datum {
  Datum({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
