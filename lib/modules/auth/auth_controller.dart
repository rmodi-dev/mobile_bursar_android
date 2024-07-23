import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api.dart';
import 'package:mobile_bursar_android/models/models.dart';
import 'package:mobile_bursar_android/routes/app_pages.dart';
import 'package:mobile_bursar_android/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginUsernameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      if (!registerTermsChecked) {
        CommonWidget.toast(
            'First agree to the Terms & Conditions and Privacy Policy to be registered.');
        return;
      }

      final response = await apiRepository.register(
        RegisterRequest(
          userName: registerUsernameController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );

      Get.find<SharedPreferences>();
      if (response!.success) {
        Get.snackbar(
            'Message', 'Registration successful. Please proceed to login.');
        Get.toNamed(Routes.login);
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    }
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      final response = await apiRepository.login(
        LoginRequest(
          userName: loginUsernameController.text,
          password: loginPasswordController.text,
        ),
      );

      final prefs = Get.find<SharedPreferences>();
      if (response?.token != null && response!.token.isNotEmpty) {
        Get.snackbar('Message', 'Login successful');
        prefs.setString(StorageConstants.token, response.token);
        Get.toNamed(Routes.studentsHome);
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    }
  }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginUsernameController.dispose();
    loginPasswordController.dispose();
  }
}
