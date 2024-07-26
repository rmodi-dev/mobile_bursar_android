import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _checkAuthentication();
    // return const Scaffold(
    //   body: Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_bottom,
            color: ColorConstants.darkGray,
            size: 48.0,
          ),
          const Text(
            'Mobile Bursar Loading ...',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

void _checkAuthentication() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');

  if (token != null) {
    Get.offNamed(Routes.studentsHome);
  } else {
    Get.offNamed(Routes.auth);
  }
}
