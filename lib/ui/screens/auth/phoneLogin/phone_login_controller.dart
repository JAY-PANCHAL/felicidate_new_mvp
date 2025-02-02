import 'dart:async';

import 'package:felicidade/common/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/base_controller.dart';



class PhoneLoginController extends BaseController {

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




}
