import 'package:get/get.dart';
import 'package:mobile_bursar_android/shared/services/services.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
