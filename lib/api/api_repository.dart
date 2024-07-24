import 'dart:async';

import 'package:mobile_bursar_android/models/models.dart';
import 'package:mobile_bursar_android/models/response/users_response.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login('/auth/login', data);
    if (res.statusCode == 200) {
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

  Future<UsersResponse?> getStudents() async {
    final res = await apiProvider.getStudents('/students/list');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
    return null;
  }
}
