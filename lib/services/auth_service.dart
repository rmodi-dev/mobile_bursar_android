import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userName': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
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

      if (response.statusCode.toString().contains('20')) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['token']) {
          await secureStorage.write(key: 'token', value: responseBody['token']);
        }
        return responseBody;
      } else {
        debugPrint('Auth service login failed: ${response.body}');
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      debugPrint('Auth service login caught error: $e');
      throw Exception('Failed to login: $e');
    }
  }

  Future checkToken() async {
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null || token.isEmpty) {
        return 'false';
      }
      final response = await http.post(
        Uri.parse('$baseUrl/auth/checkToken'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
        body: jsonEncode(<String, String>{
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Token validation failed: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'token');
  }
}
