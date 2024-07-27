import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_bursar_android/api/api.dart';
import 'package:mobile_bursar_android/models/models.dart';
import 'package:mobile_bursar_android/modules/home/student_home_controller.dart';

class ApiRepository {
  final ApiProvider apiProvider;
  final Dio dio;

  ApiRepository({required this.apiProvider, required this.dio});

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login('/auth/login', data);
    if (res.statusCode.toString().contains('20')) {
      return LoginResponse.fromJson(res.body);
    }
    return null;
  }

  Future<RegisterResponse?> register(RegisterRequest data) async {
    final res = await apiProvider.register('/auth/register', data);
    if (res.statusCode == 200) {
      return RegisterResponse.fromJson(res.body);
    }
    return null;
  }

  Future<List<Student>> getStudents() async {
    final res = await apiProvider.getStudents('/students/list');
    if (res.statusCode == 200) {
      debugPrint('Response body: ${res.body}');
      List<dynamic> data = res.body['data'];
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      debugPrint('API repository failed to get students');
      throw Exception('Failed to get students');
    }
  }
}
