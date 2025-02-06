import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/app_valid.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/auth/onboarding/onboarding2/two_onboarding_controller.dart';
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
import '../../../../widget/image_view.dart';





class TwoOnboardingScreen extends StatefulWidget {
  const TwoOnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => TwoOnboardingScreenState();
}

class TwoOnboardingScreenState extends State<TwoOnboardingScreen> {
  final TwoOnboardingController twoOnboardingController = Get.put(TwoOnboardingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TwoOnboardingController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: twoOnboardingController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFFF4F7),
                  Color(0xFFE5F7FF),
                ],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageView(
                  width: 60.sp,
                  height: 60.sp,
                  boxFit: BoxFit.contain,
                  image: AppSvgIcons.onBord2ButtomIcon,
                  imageType: ImageType.svg,
                ),
                SizedBox(width: 10.w,),
                Text(Strings.thisHelpsUsWith,style: Styles.textFontMedium(size: 14),)
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 45.h,),
                AppConstants.CommonProgressIndicator(value: 0.68,color: RED_DARK),
                SizedBox(height: 20.h,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.isThereAnything,style: Styles.textFontBold(size: 28,color: RED_DARK),),
                        SizedBox(height: 13.h,),
                        Text(Strings.weCanConnectYouWithTheRightPerson,style: Styles.textFontMedium(size: 13,color: GREY_COLOR),),
                        SizedBox(height: 15.h,),
                        commonList(),



                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }


  Widget commonList(){
    return Container(
        width: 1.sw,
        decoration: BoxDecoration(
            border: Border.all(color: DIVIDER_COLOR2,width: 1.3),
            borderRadius: BorderRadius.circular(10)
        ),
        child: ListView.separated(

          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            List sList = [
              'I’m feeling anxious or panicky',
              'I’m having difficulty in my relationship',
              'A traumatic experience (past or present)',
              'I’ve been having trouble sleeping',
              'I’m dealing with addiction or substance abuse',
              'I’m feeling down or depressed',
              'I’m dealing with stress',
              'Something else',
            ];

            List sListIcon = [
              AppSvgIcons.iconB2Icon1,
              AppSvgIcons.iconB2Icon2,
              AppSvgIcons.iconB2Icon3,
              AppSvgIcons.iconB2Icon4,
              AppSvgIcons.iconB2Icon5,
              AppSvgIcons.iconB2Icon6,
              AppSvgIcons.iconB2Icon7,
              AppSvgIcons.iconB2Icon8,

            ];
            return GestureDetector(
              onTap: (){
                Get.toNamed(Routes.threeOnboardingScreen);
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h,bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10.w,),
                      ImageView(
                        width: 25.sp,
                        height: 25.sp,
                        boxFit: BoxFit.contain,
                        image: sListIcon[index],
                        imageType: ImageType.svg,
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                          width: 1.sw * 0.75,
                          child: Text(sList[index],style: Styles.textFontMedium(size: 14,color: DARK_GREY),))

                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 0,color: DIVIDER_COLOR2,thickness: 1.3,);
          },
        )

    );
  }




}
