import 'dart:async';
import 'dart:convert';

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



class CreateStoryController extends BaseController {

  final repository = getIt.get<FelicidadeRepository>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();



  }


  Future<void> apiCallForCreateNewJournal(context) async {
    isLoading.value = true;


    Map<String, dynamic> params = Endpoints.getCommonParam();
    params['journal_title'] = titleController.text;
    params['journal_description'] = summaryController.text;
    params['journal_entry_date'] = AppConstants().getCurrentDate();

    await repository.createNewJournalRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        LoginModel model = LoginModel.fromJson(data);
        if (model.status == true) {
          AppConstants.showToast(model.message??"");
          Get.back(result: 'update');

        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForCreateNewJournal(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
      }
    });
  }



}
