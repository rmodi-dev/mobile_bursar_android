import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_bursar_android/api/api.dart';

class StudentService {
  final String baseUrl;
  final http.Client client;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  StudentService({http.Client? client, this.baseUrl = ApiConstants.baseUrl})
      : client = client ?? http.Client();

  Future<List<dynamic>> getStudents() async {
    final token = await secureStorage.read(key: 'authToken');
    final response = await http.get(
      Uri.parse('$baseUrl/students/list'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': '$token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'authToken');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'authToken');
  }
}
