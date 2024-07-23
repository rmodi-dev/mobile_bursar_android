import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/modules/auth/auth.dart';
import 'package:mobile_bursar_android/routes/routes.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:
            const Color(0xFF05F2FF), // Set the background color here

        // backgroundColor: Colors.cyanAccent,

        // body: Container(
        // decoration: const BoxDecoration(
        // gradient: LinearGradient(
        // colors: [Colors.blueAccent, Colors.redAccent],
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        // ),
        // ),
        // child: Center(
        // child: _buildItems(context),
        // ),

        body: Center(
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      children: [
        Icon(
          Icons.groups_rounded,
          size: SizeConfig().screenWidth * 0.4,
          color: Colors.indigo,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Mobile Bursar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.largeText,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Student Fees Management System',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.smallText,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        const SizedBox(height: 50.0),
        GradientButton(
          text: 'Login',
          onPressed: () {
            Get.toNamed(Routes.auth + Routes.login, arguments: controller);
          },
        ),
        const SizedBox(height: 20.0),
        BorderButton(
          text: 'Sign Up',
          onPressed: () {
            Get.toNamed(Routes.auth + Routes.register, arguments: controller);
          },
        ),
        const SizedBox(height: 62.0),
        Text(
          'By Robert Modi@PowellPay',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.smallText,
            color: ColorConstants.darkScaffoldBackgroundColor,
          ),
        ),
      ],
    );
  }
}