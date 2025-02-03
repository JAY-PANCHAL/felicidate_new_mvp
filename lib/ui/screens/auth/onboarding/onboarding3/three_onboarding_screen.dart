import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/app_valid.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/auth/onboarding/onboarding3/three_onboarding_controller.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phoneOtp/phone_otp_controller.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phone_login_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';





class ThreeOnboardingScreen extends StatefulWidget {
  const ThreeOnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => ThreeOnboardingScreenState();
}

class ThreeOnboardingScreenState extends State<ThreeOnboardingScreen> {
  final ThreeOnboardingController threeOnboardingController = Get.put(ThreeOnboardingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ThreeOnboardingController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: threeOnboardingController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }





}
