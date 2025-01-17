import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/modules/auth/auth_controller.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.arguments;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonWidget.appBar(
            context,
            'Login',
            Icons.arrow_back,
            Colors.white,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
        ),
      ],
    );
  }

  Widget _buildForms(BuildContext context) {
    const String userNamePattern = r'^[a-zA-Z][a-zA-Z0-9-_]{3,11}$';
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: controller.loginUsernameController,
              keyboardType: TextInputType.text,
              labelText: 'Username',
              placeholder: 'Enter your username',
              validator: (value) {
                RegExp regex = RegExp(userNamePattern);
                if (value!.isEmpty) {
                  return 'Username is required.';
                }
                if (!regex.hasMatch(value)) {
                  return 'Username length is 4 to 12 characters, may only contain English alphabet\nletters, numbers, dash, and underscore; and cannot begin with a number.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            InputField(
              controller: controller.loginPasswordController,
              keyboardType: TextInputType.text,
              labelText: 'Password',
              placeholder: 'Enter your password',
              password: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required.';
                }
                if (value.length < 6 || value.length > 15) {
                  return 'Password length should be 6 to 15 characters.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(height: 80),
            BorderButton(
              text: 'Login',
              backgroundColor: Colors.white,
              onPressed: () {
                controller.login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
