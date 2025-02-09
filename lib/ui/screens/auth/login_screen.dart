import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/routes/app_pages.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../common/utils/app_constants.dart';
import '../../../common/utils/strings.dart';
import '../../widget/image_view.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<LoginController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: loginController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          body: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppPngIcons.loginBack),fit: BoxFit.cover),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h,),
                  Text(Strings.felicidade,style: Styles.textFontBold(size: 50,color: WHITE,fontFamily: AppConstants.fontFamilyOgg),),
                  SizedBox(height: 10.h,),
                  Text(Strings.findYourTribe,style: Styles.textFontBold(size: 24,color: WHITE),textAlign: TextAlign.center,),
                  Spacer(),
                  CommonButton(icon: AppSvgIcons.googleSvg,text1: Strings.continueAs,text2: " Rohit Kadam",onTap: (){}),
                  CommonButton(icon: AppSvgIcons.facBookIcon,text1: Strings.signIn,text2: " ${Strings.withFacebook}", onTap: (){}),
                  CommonButton(icon: AppSvgIcons.phoneIcon,text1: "",text2: Strings.useMobileNumber,
                      onTap: (){
                    // Get.toNamed(Routes.phoneLoginScreen);
                    Get.toNamed(Routes.dashboard);
                      }),
                  SizedBox(height: 35.h,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget CommonButton({String? icon, String? text1, String? text2,onTap}){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 43.h,
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: WHITE,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView(
              width: 25.sp,
              height: 25.sp,
              boxFit: BoxFit.contain,
              image: icon??AppSvgIcons.googleSvg,
              imageType: ImageType.svg,
            ),
            SizedBox(width: 10.w,),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: text1??'',style: Styles.textFontMedium(size: 16,color: GREY_COLOR),),
                  TextSpan(text: text2??"",style: Styles.textFontMedium(size: 16),),

                ]
              ),

            ),

          ],
        ),
      ),
    );
  }

}
