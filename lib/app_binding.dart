import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    final dio = Dio();
    Get.lazyPut<ApiRepository>(
        () => ApiRepository(dio: dio, apiProvider: Get.find()));
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find(), dio: dio), permanent: true);
  }
}
