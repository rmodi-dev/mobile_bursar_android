import 'package:get/get.dart';
import 'package:mobile_bursar_android/modules/auth/auth.dart';
import 'package:mobile_bursar_android/modules/modules.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.register, page: () => const RegisterScreen()),
        GetPage(name: Routes.login, page: () => const LoginScreen()),
      ],
    ),
    GetPage(
      name: Routes.studentsHome,
      page: () => const StudentHomeScreen(),
      binding: StudentHomeBinding(),
    ),
  ];
}
