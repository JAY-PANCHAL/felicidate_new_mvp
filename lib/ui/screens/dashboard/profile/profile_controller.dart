import 'dart:async';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/base_controller.dart';
import '../../../../common/utils/shared_pref_utils.dart';
import '../../../../network/model/login_model.dart';



class ProfileController extends BaseController {

  var mLoginData = Rxn<User>();


  @override
  Future<void> onInit() async {
    getLoginUserData();
    super.onInit();
  }

  getLoginUserData() async {
    mLoginData.value = await getUser();
    print('mLoginData.value--${mLoginData.value?.email??""}');

  }


}
