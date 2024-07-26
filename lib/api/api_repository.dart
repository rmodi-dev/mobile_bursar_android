import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_bursar_android/models/models.dart';

import '../modules/home/student_home_controller.dart';
import 'api.dart';

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
      // List<dynamic> data = res.body['data'];
      debugPrint('Response body: ${res.body}');
      List<dynamic> data = res.body['data'];
      return data.map((json) => Student.fromJson(json)).toList();
      // return res.body['data'].map((json) => Student.fromJson(json)).toList();
    } else {
      debugPrint('API repository failed to get students');
      throw Exception('Failed to get students');
    }
  }

  // Future<List<Student>> getStudents() async {
  //   const baseUrl = ApiConstants.baseUrl;
  //   final response = await dio.get('$baseUrl/students/list');
  //   if (response.statusCode == 200) {
  //     List<dynamic> data = response.data;
  //     return data.map((json) => Student.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load students');
  //   }
  // }
}
