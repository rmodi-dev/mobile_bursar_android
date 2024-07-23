import 'package:flutter/material.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return Container(
    //   Child: Column(
    //     Children: [
    //
    //     ]
    //   )
    // )
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
            'Mobile Bursar ...',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
