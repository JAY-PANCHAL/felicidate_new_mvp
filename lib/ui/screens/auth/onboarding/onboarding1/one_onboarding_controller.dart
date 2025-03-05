import 'dart:async';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../common/utils/app_constants.dart';
import '../../../../../controller/base_controller.dart';

class OneOnboardingController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    var data = Get.arguments;
    if (data != null) {
      print(data);
      nameController.text = data['name'] ?? "";
      emailController.text = data['email'] ?? "";
    }

    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      locationController.text = await AppConstants().getCityFromLatLong(
              position.latitude ?? 0.0, position.longitude ?? 0.0) ??
          "";
    } else if (status.isDenied) {
      getCurrentLocation();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
