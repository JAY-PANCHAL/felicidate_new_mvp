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
import '../../../../../common/utils/strings.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../widget/gradient_text.dart';
import '../../../../widget/image_view.dart';





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
          // bottomNavigationBar:
          body: SafeArea(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFCDF),
                    Color(0xFFF9FDFF),
                    Color(0xFFFFF5F8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: AppConstants.CommonProgressIndicator2(),
                  ),
                  SizedBox(height: 20.h,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          GradientText(
                          text: Strings.youAreReadyToShine,
                          style: Styles.textFontBold(size: 28,),
                          gradient: LinearGradient(
                            colors: [Color(0xFF86D8FF), Color(0xFFFF9FB2), Color(0xFFFFD18E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          ),
                            SizedBox(height: 13.h,),
                            Text(Strings.weCanConnectYouWithTheRightPerson,style: Styles.textFontMedium(size: 13,color: GREY_COLOR),),
                            SizedBox(height: 35.h,),

                            CommonWidget(icon: AppSvgIcons.iconB3Icon1, text: "Talk to people who understand you."),
                            CommonWidget(icon: AppSvgIcons.iconB3Icon2, text: "Get expert advice from professionals."),
                            CommonWidget(icon: AppSvgIcons.iconB3Icon3, text: "Go on trips and meet exciting new people.")


                          ],
                        ),
                      ),
                    ),
                  ),
                  AppConstants.CommonButtom(
                      text: Strings.txtContinue,
                      onTap: (){
                        Get.offNamedUntil(Routes.dashboard,(route) => false);
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget CommonWidget({String? icon, String? text}){
    return  Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: GREY_COLOR.withOpacity(0.2), // Shadow color
                  spreadRadius: 0, // Slight spread to keep the shadow subtle
                  blurRadius: 10, // Increased blur for a softer shadow
                  offset: Offset(0, 0), // Shadow appears below (positive y-axis)
                ),
              ],
            ),
            child: ImageView(
              width: 70.sp,
              height: 70.sp,
              boxFit: BoxFit.contain,
              image: icon??"",
              imageType: ImageType.svg,
            ),
          ),
          SizedBox(width: 19.w,),
          SizedBox(
              width: 1.sw * 0.65,
              child: Text(text??"",style: Styles.textFontMedium(size: 18),)),
        ],
      ),
    );
  }




}
