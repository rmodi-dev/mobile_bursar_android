import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_bursar_android/api/api.dart';

class StudentService {
  final String baseUrl = ApiConstants.baseUrl;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<List<dynamic>> getStudents() async {
    final token = await secureStorage.read(key: 'authToken');
    final response = await http.get(
      Uri.parse('$baseUrl/students/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load students');
    }
  }
}
