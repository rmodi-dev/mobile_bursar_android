import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/base_provider.dart';
import 'package:mobile_bursar_android/models/models.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }
}
