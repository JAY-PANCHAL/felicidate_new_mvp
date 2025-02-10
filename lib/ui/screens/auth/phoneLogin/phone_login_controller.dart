import 'dart:async';
import 'dart:convert';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/service_locator.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/strings.dart';
import '../../../../controller/base_controller.dart';
import '../../../../network/api/Felicidade_repository.dart';
import '../../../../network/constant/endpoints.dart';
import '../../../widget/constants/app_colors.dart';



class PhoneLoginController extends BaseController {


  final repository = getIt.get<FelicidadeRepository>();


  final formKey = GlobalKey<FormState>();

  TextEditingController number =  TextEditingController();

  var preNum = "+91".obs;

  var preNumList = [
    '+1',   // United States/Canada
    '+44',  // United Kingdom
    '+91',  // India
    '+61',  // Australia
    '+81',  // Japan
    '+49',  // Germany
    '+33',  // France
    '+86',  // China
    '+7',   // Russia
    '+39',  // Italy
    '+34',  // Spain
    '+55',  // Brazil
    '+27',  // South Africa
    '+82',  // South Korea
    '+47',  // Norway
    '+31',  // Netherlands
    '+64',  // New Zealand
    '+65',  // Singapore
    '+60',  // Malaysia
    '+62',  // Indonesia
  ];

  @override
  Future<void> onInit() async {
    super.onInit();



  }



  Future<void> apiCallForLogin(context) async {
    isLoading.value = true;


    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['email'] = "";
    params['password'] = "";

    await repository.loginMobileRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        // LoginModel model = LoginModel.fromJson(data);
        // if (model.status == AppConstants.status200) {
        //   await setUser(model);
        //   await SpUtil.putString(ACCESS_TOKEN, model.data?.accessToken??"");
        //   // print('==> Auth token : ${model.data?.accessToken}');
        //   // AppConstants.showToast(model.message,context);
        //   if(model.data?.subscriptionData?.id==null){
        //     Get.offNamedUntil(Routes.accountSubscriptionScreen,(route) => false);
        //   }
        //   else{
        //     Get.offNamedUntil(Routes.telepecasScreen,(route) => false);
        //   }
        // }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e, context, () {
          apiCallForLogin(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e,RED);
      }
    });
  }

}
