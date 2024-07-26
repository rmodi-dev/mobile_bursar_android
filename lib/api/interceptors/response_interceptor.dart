import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mobile_bursar_android/models/models.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  EasyLoading.dismiss();
  responseLogger(response);

  if (!response.statusCode.toString().contains('20')) {
    handleErrorStatus(response);
    return;
  }

  return response;
}

void handleErrorStatus(Response response) {
  final message = ErrorResponse.fromJson(response.body);
  CommonWidget.toast(message.error);
  // switch (response.statusCode) {
  //   case 400:
  //     final message = ErrorResponse.fromJson(response.body);
  //     CommonWidget.toast(message.error);
  //     break;
  //   default:
  // }

  return;
}

void responseLogger(Response response) {
  debugPrint('Status Code: ${response.statusCode}\n');
  debugPrint('Data: ${response.bodyString?.toString() ?? ''}');
}
