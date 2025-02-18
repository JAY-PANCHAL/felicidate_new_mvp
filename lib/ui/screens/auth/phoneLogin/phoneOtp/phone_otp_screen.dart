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
import '../../../../../routes/app_pages.dart';
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
                if(phoneOtpController.isOtpFilled()){
                  AppConstants.showToast(Strings.validOtp);
                }
                else{
                  phoneOtpController.apiCallForVerifyOtp(context);
                }

              }
          ),
          body: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE7F7FF),
                  WHITE,
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
                    SizedBox(height: 45.h,),
                    Text(Strings.enterYourCode,style: Styles.textFontBoldHeight(size: 40,color: BLUE_COLOR),),
                    SizedBox(height: 10.h,),
                    Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(text: Strings.sFor,style: Styles.textFontMedium(size: 18,color: GREY_COLOR),),
                            TextSpan(text: '${phoneOtpController.preNum.value} ${phoneOtpController.number.value}',style: Styles.textFontMedium(size: 18),),
                          ]
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    otpWidget(),
                    GestureDetector(
                      onTap: (){
                        phoneOtpController.apiCallForResendOtp(context);
                      },
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(text: Strings.didNotGetOtp,style: Styles.textFontMedium(size: 16,color: GREY_COLOR),),
                              TextSpan(
                                text: Strings.sendOtpAgain,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: BLUE_COLOR,fontFamily: AppConstants.fontFamilySatoshi,decoration: TextDecoration.underline),),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget otpWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 65.sp,
          height: 70.sp,
          child: TextField(
            // autofocus: index == 0, // Focus on the first field
            controller: phoneOtpController.otpController[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '', // Hides the counter
              filled: true,
              fillColor: WHITE,
              focusColor: WHITE,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                    color: DIVIDER_COLOR,
                    width: 1
                ),
              ),

              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: DIVIDER_COLOR, // Color when focused
                  width: 1,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: RED, // Color when focused
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: PRIMARY_COLOR, // Color when focused
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: DIVIDER_COLOR,
                  width: 1,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              print("dsdd=${value}");
            },
          ),
        );
      }),
    );
  }




}
