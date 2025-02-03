import 'dart:async';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    if(data!=null){

    }
    super.onInit();
  }




}
