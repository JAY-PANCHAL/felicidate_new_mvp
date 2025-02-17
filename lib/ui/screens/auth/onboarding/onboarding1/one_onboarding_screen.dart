import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/app_valid.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/routes/app_pages.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phoneOtp/phone_otp_controller.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phone_login_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/CommanTextField.dart';
import '../../../../../common/utils/app_constants.dart';


import '../../../../../common/utils/strings.dart';
import '../../../../widget/image_view.dart';
import 'one_onboarding_controller.dart';



class OneOnboardingScreen extends StatefulWidget {
  const OneOnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => OneOnboardingScreenState();
}

class OneOnboardingScreenState extends State<OneOnboardingScreen> {
  final OneOnboardingController oneOnboardingController = Get.put(OneOnboardingController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      oneOnboardingController.getCurrentLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<OneOnboardingController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: oneOnboardingController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          bottomNavigationBar: AppConstants.CommonButtom(
              text: Strings.txtContinue,
              onTap: (){
                 if (oneOnboardingController.formKey.currentState!.validate()) {
                  Get.toNamed(Routes.twoOnboardingScreen,arguments: {
                    'name': oneOnboardingController.nameController.text,
                    'email': oneOnboardingController.emailController.text,
                    'age': oneOnboardingController.ageController.text,
                    'location': oneOnboardingController.locationController.text,
                  });
                }

              }
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 45.h,),
                AppConstants.CommonProgressIndicator(value: 0.32),
                SizedBox(height: 20.h,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: oneOnboardingController.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.tellMoreAboutYou,style: Styles.textFontBoldHeight(size: 40,color: DARK_GREY),),
                          SizedBox(height: 13.h,),
                          Text(Strings.weSupportBothListeners,style: Styles.textFontMedium(size: 16,color: GREY_COLOR),),
                          SizedBox(height: 35 .h,),
                          nameWidget(),
                          SizedBox(height: 13.h,),
                          emailWidget(),
                          SizedBox(height: 4.h,),
                          Text(Strings.notSendYouAnyPromotionalMails,style: Styles.textFontMedium(size: 12,color: DARK_GREY),),
                          SizedBox(height: 13.h,),
                          ageWidget(),
                          SizedBox(height: 13.h,),
                          locationWidget(),
                          SizedBox(height: 13.h,),

                        ],
                      ),
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

  Widget nameWidget(){
    return CustomTextField(
      controller: oneOnboardingController.nameController,
      validator: (value) => commonValidation(value,Strings.errorName),
      titleLabel: Strings.yourName,
    );
  }

  Widget emailWidget(){
    return CustomTextField(
      controller: oneOnboardingController.emailController,
      validator: (value) => validateEmailAddress(value),
      titleLabel: Strings.yourEmailID,
    );
  }


  Widget ageWidget(){
    return CustomTextField(
      controller: oneOnboardingController.ageController,
      validator: (value) => commonValidation(value,Strings.errorAge),
      keyboardType: TextInputType.number,
      readOnly: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
      ],
      titleLabel: Strings.oldYouAre,
      suffixIcon: AppSvgIcons.icCalenderIcon,
      onTap: (){
        selectDate(context);
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      int age = AppConstants().calculateAge(pickedDate);
      if(age!=0){
        oneOnboardingController.ageController.text = age.toString();
      }
      else{
        AppConstants.showToast(Strings.validDate);
      }

    }
  }


  Widget locationWidget(){
    return CustomTextField(
      controller: oneOnboardingController.locationController,
      validator: (value) => commonValidation(value,Strings.errorLocation),
      titleLabel: Strings.location,
      suffixIcon: AppSvgIcons.icLocationIcon,
      hintText: "Fetching location...",
      suffixIconTap: (){
        oneOnboardingController.getCurrentLocation();
      },

    );
  }

}
