import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mobile_bursar_android/modules/auth/auth_controller.dart';

FutureOr<Request> requestInterceptor(request) async {
  final token = await Get.find<AuthController>().readStoredToken();
  debugPrint('Token read by interceptor from Secure Storage: $token');

  request.headers['x-access-token'] = '$token';

  EasyLoading.show(status: 'loading...');
  requestLogger(request);
  return request;
}

void requestLogger(Request request) {
  debugPrint('Url: ${request.method} ${request.url}\n');
}
