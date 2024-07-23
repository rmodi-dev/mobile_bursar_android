import 'package:get/get.dart';

import 'student_home_controller.dart';

class StudentHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentHomeController>(
        () => StudentHomeController(apiRepository: Get.find()));
    // Get.lazyPut<StudentHomeController>(() => StudentHomeController());
  }
}
