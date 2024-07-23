import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_bursar_android/api/api.dart';

class AuthService {
  final String baseUrl;
  final http.Client client;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthService({http.Client? client, this.baseUrl = ApiConstants.baseUrl})
      : client = client ?? http.Client();

  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': username,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['token']) {
        await secureStorage.write(
            key: 'authToken', value: responseBody['token']);
      }
      return responseBody;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'authToken');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'authToken');
  }
}
