import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api.dart';
import 'package:mobile_bursar_android/models/models.dart';
import 'package:mobile_bursar_android/modules/auth/login_screen.dart';
import 'package:mobile_bursar_android/modules/home/student_home_screen.dart';
import 'package:mobile_bursar_android/routes/app_pages.dart';
import 'package:mobile_bursar_android/services/auth_service.dart';
import 'package:mobile_bursar_android/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final tokenStorage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
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

  Future<void> register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      if (!registerTermsChecked) {
        CommonWidget.toast(
            'First agree to the Terms & Conditions and Privacy Policy to be registered.');
        return;
      }

      try {
        final response = await apiRepository.register(
          RegisterRequest(
            userName: registerUsernameController.text,
            email: registerEmailController.text,
            password: registerPasswordController.text,
          ),
        );

        Get.find<SharedPreferences>();
        if (response != null && response.status != '') {
          Get.snackbar(
            'Success',
            'Registration successful. Please proceed to login.',
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.toNamed(Routes.login);
        } else {
          CommonWidget.toast(
              'Registration failed. Check your network connection');
        }
      } catch (e) {
        CommonWidget.toast('Failed to register, ERROR: $e');
      }
    }
  }

  Future<void> login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      try {
        final response = await apiRepository.login(
          LoginRequest(
            userName: loginUsernameController.text,
            password: loginPasswordController.text,
          ),
        );

        if (response != null && response.token != '') {
          final prefs = Get.find<SharedPreferences>();
          await prefs.setString('token', response.token);
          await tokenStorage.write(key: 'token', value: response.token);
          Get.toNamed(Routes.studentsHome);
        } else {
          CommonWidget.toast('Login failed.');
          Get.snackbar(
            'Error',
            'Login failed.',
            snackPosition: SnackPosition.BOTTOM,
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Login failed.')),
          // );
        }
      } catch (e) {
        debugPrint('Failed to login, ERROR: $e');
        CommonWidget.toast('Failed to login.');
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

  Future<String?> readStoredToken() async {
    try {
      String? token = await tokenStorage.read(key: 'token');
      return token;
    } catch (e) {
      debugPrint('Error reading stored token: $e');
      return null;
    }
  }

  void checkToken() async {
    try {
      final response = await _authService.checkToken();
      if (response.toString().contains('Token expires')) {
        Get.off(() => const StudentHomeScreen());
      } else {
        Get.snackbar('Notice', 'Authentication token expired.');
        Get.off(() => const LoginScreen());
      }
    } catch (e) {
      debugPrint('Auth controller could not verify token: $e.');
      CommonWidget.toast('Could not verify token. Check your connection.');
      Get.off(() => const LoginScreen());
    }
  }
}
