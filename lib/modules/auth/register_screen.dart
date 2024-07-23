import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/modules/auth/auth.dart';
import 'package:mobile_bursar_android/services/auth_service.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonWidget.appBar(
            context,
            'Sign Up',
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
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: controller.registerUsernameController,
              keyboardType: TextInputType.text,
              labelText: 'Username',
              placeholder: 'Enter a username',
              validator: (value) {
                RegExp regex = RegExp(userNamePattern);
                if (!regex.hasMatch(value!)) {
                  return 'Username length is 4 to 12. Only allows English alphabet letters, numbers, dash, and underscore; and cannot begin with a number.';
                }
                if (value.isEmpty) {
                  return 'Username is required.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            InputField(
              controller: controller.registerEmailController,
              keyboardType: TextInputType.emailAddress,
              labelText: 'Email address',
              placeholder: 'Enter your email address',
              validator: (value) {
                if (!Regex.isEmail(value!)) {
                  return 'Email format error.';
                }
                if (value.isEmpty) {
                  return 'Email is required.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            InputField(
              controller: controller.registerPasswordController,
              keyboardType: TextInputType.text,
              labelText: 'Password',
              placeholder: 'Enter a password',
              password: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required.';
                }
                if (value.length < 6 || value.length > 15) {
                  return 'Password length must be 6 to 15 characters.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(),
            InputField(
              controller: controller.registerConfirmPasswordController,
              keyboardType: TextInputType.text,
              labelText: 'Confirm password',
              placeholder: 'Re-enter password',
              password: true,
              validator: (value) {
                if (controller.registerPasswordController.text !=
                    controller.registerConfirmPasswordController.text) {
                  return 'Passwords do not match.';
                }
                if (value!.isEmpty) {
                  return 'Confirm Password is required.';
                }
                return null;
              },
            ),
            CommonWidget.rowHeight(height: 10.0),
            AppCheckbox(
              label:
                  'I have read and understood, and I agree to the Mobile Bursar Terms & Conditions and Privacy Policy.',
              checked: controller.registerTermsChecked,
              onChecked: (val) {
                controller.registerTermsChecked = val!;
              },
            ),
            CommonWidget.rowHeight(height: 80),
            BorderButton(
              text: 'Sign Up',
              backgroundColor: Colors.white,
              // onPressed: _register,
              onPressed: () {
                controller.register(context);
                _register;
              },
              // onPressed: () {
              //   controller.register(context);
              // },
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    final userName = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await _authService.register(userName, email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }
}
