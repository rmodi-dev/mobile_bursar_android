import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/services/student_service.dart';

import '../../api/api_repository.dart';

class StudentHomeController extends GetxController {
  final StudentService studentService = StudentService();
  final ApiRepository apiRepository;

  StudentHomeController({required this.apiRepository});

  var isLoading = true.obs;
  var students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  void fetchStudents() async {
    isLoading(true);
    try {
      var fetchedStudents = await apiRepository.getStudents();
      students.assignAll(fetchedStudents);
      debugPrint('Student Home Controller fetched students: $fetchedStudents.');
      debugPrint('Student Home Controller assigned students: $students.');
    } catch (e) {
      debugPrint('Student Home Controller Error fetching students: $e');
    } finally {
      isLoading(false);
    }
  }
}

class Student {
  Student({
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

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["studentId"].toString(),
        firstName: json["firstName"].toString(),
        lastName: json["lastName"].toString(),
        currentClass: json["currentClass"].toString(),
        gender: json["gender"].toString(),
        physicalAddress: json["physicalAddress"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "firstName": firstName,
        "lastName": lastName,
        "currentClass": currentClass,
        "gender": gender,
        "physicalAddress": physicalAddress,
      };
}
