import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/app_valid.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phoneOtp/phone_otp_controller.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phone_login_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/app_constants.dart';

import '../../../../../common/utils/strings.dart';
import '../../../../widget/image_view.dart';



class PhoneOtpScreen extends StatefulWidget {
  PhoneOtpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneOtpScreenState();
}

class PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final PhoneOtpController phoneOtpController = Get.put(PhoneOtpController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PhoneOtpController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: phoneOtpController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          floatingActionButton: AppConstants.CommonFloatButton(
              onTap: (){

              }
          ),
          body: SafeArea(
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    LIGHT_BLUE2,
                    LIGHT_BLUE1,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h,),
                      Text(Strings.startedWithYourNumber,style: Styles.textFontBold(size: 30,color: BLUE_COLOR),),
                      SizedBox(height: 50.h,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }




}
