import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/service_locator.dart';
import '../common/utils/app_constants.dart';
import '../common/utils/storage_service.dart';
import '../common/utils/utility.dart';
import '../network/api/Felicidade_repository.dart';

import '../routes/app_pages.dart';
import 'base_controller.dart';

class LoginController extends BaseController {
  String deviceType = "";
  var isObscure = false.obs;
  var accepted = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var otpValue = "".obs;

  validate(BuildContext context) async {
    Get.focusScope?.unfocus();

    if (emailController.text.isEmpty) {
      Utils.showToast(AppConstants.errorEmail);
    } else if (!Utils.isEmail(emailController.text)) {
      Utils.showToast(AppConstants.validEmail);
    } else if (passwordController.text.isEmpty) {
      Utils.showToast(AppConstants.errorPassword);
    } else {
      loginApiCall();
    }
  }

  Future loginApiCall() async {
    var params = {
      AppConstants.loginK: emailController.text,
      AppConstants.passwordK: passwordController.text,
      AppConstants.dbK: AppConstants.dbname,
      AppConstants.device_typeK: 1,
    };


    isLoading.value = true;
    await repo.getToken(params).then((value) async {
      isLoading.value = false;
      if (value.data?.uid != "") {
        var data = value;
        if (data.success == 1) {
          await storageService.setString(
              AppConstants.tokenPr, data.data?.token);
          print("user id  =======> ${data.data?.uid}");
          print("user id  =======> ${data.data?.userType}");

          await storageService.setString(AppConstants.userIDPr, data.data?.uid.toString());
          await storageService.setString(AppConstants.userTypePr, data.data?.userType.toString());
          await storageService.setBool(AppConstants.loginPref,true);



          print(data.data?.token);
          Get.offAllNamed(Routes.dashboard);
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.showToast(error.toString());
    });
  }
}
