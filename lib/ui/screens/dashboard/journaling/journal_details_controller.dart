import 'dart:async';
import 'dart:convert';

import 'package:felicidade/network/model/diary_details_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/service_locator.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/strings.dart';
import '../../../../controller/base_controller.dart';
import '../../../../network/api/Felicidade_repository.dart';
import '../../../../network/constant/endpoints.dart';
import '../../../../network/model/login_model.dart';
import '../../../widget/constants/app_colors.dart';



class DiaryDetailsController extends BaseController {

  final repository = getIt.get<FelicidadeRepository>();

  final formKey = GlobalKey<FormState>();
  var diaryDetailModel = DiaryDetailsResponse().obs;

  @override
  Future<void> onInit() async {
    super.onInit();



  }


  Future<void> apiCallForDiaryDetails(context,int id) async {
    isLoading.value = true;

    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['diary_id'] = id;


    await repository.getDiaryDetailsApi(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        DiaryDetailsResponse model = DiaryDetailsResponse.fromJson(data);
        diaryDetailModel.value=model;
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForDiaryDetails(context,id);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
      }
    });
  }



}
