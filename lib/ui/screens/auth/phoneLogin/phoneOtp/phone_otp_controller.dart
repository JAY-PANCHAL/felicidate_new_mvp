import 'dart:async';
import 'dart:convert';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/service_locator.dart';
import '../../../../../common/utils/app_constants.dart';
import '../../../../../common/utils/shared_pref_utils.dart';
import '../../../../../common/utils/sp_util.dart';
import '../../../../../common/utils/strings.dart';
import '../../../../../controller/base_controller.dart';
import '../../../../../network/api/Felicidade_repository.dart';
import '../../../../../network/constant/endpoints.dart';
import '../../../../../network/model/login_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../widget/constants/app_colors.dart';



class PhoneOtpController extends BaseController {

  var preNum = "".obs;
  var number = "".obs;

  final repository = getIt.get<FelicidadeRepository>();

  List<TextEditingController> otpController = List.generate(4, (index) => TextEditingController());

  bool isOtpFilled() {
    return otpController.every((controller) => controller.text.isEmpty);
  }

  String getOtpValue() {
    return otpController.map((controller) => controller.text).join();
  }
  @override
  Future<void> onInit() async {
    var data = Get.arguments;
    if(data!=null){
      preNum.value = data['preNum'];
      number.value = data['number'];
    }
    super.onInit();
  }


  Future<void> apiCallForResendOtp(context) async {
    isLoading.value = true;


    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['mobile_number'] = number.value;

    await repository.resendOtpRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        LoginModel model = LoginModel.fromJson(data);
        if (model.status == true) {
          AppConstants.showToast(model.message??"");
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForResendOtp(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
      }
    });
  }


  Future<void> apiCallForVerifyOtp(context) async {
    isLoading.value = true;


    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['mobile_number'] = number.value;
    params['user_otp'] = getOtpValue();

    await repository.verifyOtpRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        LoginModel model = LoginModel.fromJson(data);
        if (model.status == true) {
          await SpUtil.putString(ACCESS_TOKEN, model.data?.token??"");
          setUser(model.data?.user);
          AppConstants.showToast(model.message??"");
          var loginData = await getUser();
          if((loginData?.cityLocation??"")==""){
            Get.offNamedUntil(Routes.oneOnboardingScreen,(route) => false);
          }
          else{
            Get.offNamedUntil(Routes.dashboard,(route) => false);
          }
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForVerifyOtp(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
      }
    });
  }


}
