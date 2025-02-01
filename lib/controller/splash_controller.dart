import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../common/service_locator.dart';
import '../common/utils/app_constants.dart';
import '../common/utils/dimensions.dart';
import '../common/utils/storage_service.dart';
import '../common/utils/utility.dart';
import '../network/api/Felicidade_repository.dart';
import '../network/model/user_model.dart';
import '../routes/app_pages.dart';
import 'base_controller.dart';

class SplashController extends BaseController {
  final repo = getIt.get<FelicidadeRepository>();
  final StorageService storageService = StorageService();

  @override
  Future<void> onInit() async {
    splashTimer();
    super.onInit();
  }

  void splashTimer() async {
    var _duration = Duration(
      seconds: Dimensions.screenLoadTime,
    );

    Timer(_duration, () async {
      UserModel userModel = await Utils.getLoginData();
      if ((userModel.data?.length ?? 0) > 0) {
        Get.offNamedUntil(Routes.dashboard, (route) => false);
      } else {
        Get.offNamedUntil(Routes.welcome, (route) => false);
      }

      /*try {
        if (storage.getString(AppConstants.eventId) != null) {
          Get.offNamedUntil(Routes.dashboard, (route) => false);
        } else {
          Get.offNamedUntil(Routes.auth, (route) => false);
        }
      } catch (e) {
        Get.offNamedUntil(Routes.auth, (route) => false);
      }*/
    });
  }

  Future getTokenApi() async {
    var params = {
      AppConstants.loginK: AppConstants.loginValue,
      AppConstants.passwordK: AppConstants.passWordValue,
      AppConstants.dbK: AppConstants.dbname,
      AppConstants.device_typeK: 1,
    };

    await repo.getToken(params).then((value) async {
      if (value.data?.uid != "") {
        var data = value;
        if (data.success == 1) {
          await storageService.setString(
              AppConstants.tokenPr, data.data?.token);
          print("user id  =======> ${data.data?.uid}");
          await storageService.setInt(AppConstants.userIDPr, data.data?.uid);
          print(data.data?.token);
          Get.offAllNamed(Routes.welcome);
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Utils.showToast(error.toString());
    });
  }

/*
  Future getStateTags(context) async {

    var token = await storageService.getString(AppConstants.tokenPr);

    await repo.getState(token).then((value) async {
      if (value != null) {
        StateTagResponse data = value;
        if (data.success == 1) {
          print(jsonEncode(data.toJson()));
          await storageService.setString(
              AppConstants.stateTagResPr,jsonEncode(data.toJson()));
         var modeldata= await storageService.getString(AppConstants.stateTagResPr);
         StateTagResponse model=StateTagResponse.fromJson(jsonDecode(modeldata));
          print("  =======> ${ model.data?[0].value}");

        }
      }
    });
  }
*/
}
