import 'package:get/get.dart';
import 'package:mobile_bursar_android/routes/routes.dart';

import '../../services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = AuthService();

  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      String isValidToken = await _authService.checkToken();
      if (isValidToken == 'false') {
        Get.toNamed(Routes.auth);
      } else {
        Get.toNamed(Routes.studentsHome);
      }
    } catch (e) {
      Get.toNamed(Routes.auth);
    }
  }
}
