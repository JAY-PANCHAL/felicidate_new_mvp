import 'dart:async';
import 'dart:convert';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/network/model/save_feelings_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/base_controller.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/strings.dart';
import '../../../widget/constants/app_colors.dart';

class HomeController extends BaseController {
  @override
  Future<void> onInit() async {
    var data = Get.arguments;
    if (data != null) {}
    super.onInit();
  }

  Future<void> saveFeelingsApiCall(context, String icon) async {
    isLoading.value = true;
    var mood = "";
    if (icon == AppSvgIcons.fe1Icon) {
      mood = "Awsome";
    } else  if (icon == AppSvgIcons.fe2Icon) {
      mood = "Good";
    } else  if (icon == AppSvgIcons.fe3Icon) {
      mood = "Neutral";
    } else  if (icon == AppSvgIcons.fe4Icon) {
      mood = "Bad";
    }else  {
      mood = "Terrible";
    }

    var params = {
      "todays_feeling":mood
    };

    await repo.saveFeelingsApi(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        SaveFeelingsResponse model = SaveFeelingsResponse.fromJson(data);
        if (model.status == true) {
          AppConstants.showGetSnackBar("Success!",model.message, BACK_BUTTON_ACCENT_COLOR);

        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          saveFeelingsApiCall(context, icon);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }
}
