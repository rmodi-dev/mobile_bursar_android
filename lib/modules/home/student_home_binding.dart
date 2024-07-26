import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api_provider.dart';
import 'package:mobile_bursar_android/api/api_repository.dart';
import 'package:mobile_bursar_android/modules/home/student_home_controller.dart';

class StudentHomeBinding implements Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    Get.lazyPut<ApiRepository>(
        () => ApiRepository(apiProvider: Get.find<ApiProvider>(), dio: dio));
    Get.lazyPut<StudentHomeController>(
        () => StudentHomeController(apiRepository: Get.find<ApiRepository>()));
    Get.lazyPut<StudentHomeController>(
        () => StudentHomeController(apiRepository: Get.find()));
  }
}
