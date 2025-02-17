import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/app_valid.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/auth/phoneLogin/phone_login_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/CommanTextField.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/strings.dart';
import '../../../../routes/app_pages.dart';
import '../../../widget/image_view.dart';


class PhoneLoginScreen extends StatefulWidget {
  PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneLoginScreenState();
}

class PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final PhoneLoginController phoneLoginController = Get.put(PhoneLoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PhoneLoginController>();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
        color: Colors.black.withOpacity(0.6),
        dismissible: false,
        progressIndicator: AppConstants.loader(context),
        inAsyncCall: phoneLoginController.isLoading.value,
        child: Scaffold(
          backgroundColor: WHITE,
          floatingActionButton: AppConstants.CommonFloatButton(
            onTap: (){
              if (phoneLoginController.formKey.currentState!.validate()) {
                phoneLoginController.apiCallForSignIn(context);
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
                  Color(0xFFA8E2FF),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: phoneLoginController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 45.h,),
                      Text(Strings.startedWithYourNumber,style: Styles.textFontBoldHeight(size: 40,color: BLUE_COLOR),),
                      SizedBox(height: 50.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 80.w,
                              child: numDropDown()),
                          SizedBox(width: 10.w,),

                          Expanded(
                              child: numberWidget()
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Text(Strings.messageNumber,style: Styles.textFontMedium(size: 16,color: DARK_GREY),),


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

  Widget numberWidget(){
    return CustomTextField(
      controller: phoneLoginController.number,
      keyboardType: TextInputType.phone,
      validator: (value) => commonValidation(value,Strings.errorPhone),
      titleLabel: "",
    );
  }

  Widget numDropDown(){
    return DropdownButtonFormField(
      value: phoneLoginController.preNum.value,
      items: (phoneLoginController.preNumList ?? []).map((com) {
        return DropdownMenuItem(
          value: com,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 1.h),
            child: Text(com??"",style: Styles.textFontMedium(size: 16),),
          ),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) {
          phoneLoginController.preNum.value = val??"";
        }
      },
      icon: Padding(
        padding: EdgeInsets.only(right: 13.w),
        child: ImageView(
          width: 7.sp,
          height: 7.sp,
          boxFit: BoxFit.contain,
          image: AppSvgIcons.icDropIcon,
          imageType: ImageType.svg,
        ),
      ),
      focusColor: WHITE,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: WHITE,
        focusColor: WHITE,
        contentPadding: EdgeInsets.only(left: 0,top: 10),
        errorMaxLines: 2,
        hintText: "",
        hintStyle: Styles.textFontRegular(size: 16,color: GREY_COLOR),
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
            color: DIVIDER_COLOR, // Color when focused
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
    );
  }


}
