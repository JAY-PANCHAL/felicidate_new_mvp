import 'dart:async';
import 'dart:convert';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:felicidade/common/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/service_locator.dart';
import '../../../../../common/utils/app_constants.dart';
import '../../../../../common/utils/strings.dart';
import '../../../../../controller/base_controller.dart';
import '../../../../../network/api/Felicidade_repository.dart';
import '../../../../../network/constant/endpoints.dart';
import '../../../../../network/model/login_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../widget/constants/app_colors.dart';



class TwoOnboardingController extends BaseController {
  final repository = getIt.get<FelicidadeRepository>();


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController helpController = TextEditingController();

  final formKey = GlobalKey<FormState>();



  @override
  Future<void> onInit() async {
    var data = Get.arguments;
    if(data!=null){
      nameController.text = data['name']??"";
      emailController.text = data['email']??"";
      ageController.text = data['age']??"";
      locationController.text = data['location']??"";
    }
    super.onInit();
  }


    Future<void> apiCallForInitialDetails(context) async {
      isLoading.value = true;


      Map<String, dynamic> params = Endpoints.getCommonParam();
      params['name'] = nameController.text;
      params['email'] = emailController.text;
      params['age'] = ageController.text;
      params['city_location'] = locationController.text;
      params['reason_to_talk'] = helpController.text;

      await repository.getInitialDetailsRequested(params, context).then((value) async {
        isLoading.value = false;
        var data = jsonDecode(value);
        if (data != null) {
          LoginModel model = LoginModel.fromJson(data);
          if (model.status == true) {
            AppConstants.showToast(model.message??"");
            setUser(model.data?.user);

            Get.toNamed(Routes.threeOnboardingScreen);
          }
        }
      }, onError: (e) {
        isLoading.value = false;
        if (e.toString().contains(Strings.noInternet)) {
          AppConstants.showSnackBar(e.toString(), context, () {
            apiCallForInitialDetails(context);
          });
        } else {
          AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
        }
      });
    }



}
