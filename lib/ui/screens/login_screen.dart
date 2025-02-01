import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/CommanTextField.dart';
import '../../common/rounded_button.dart';
import '../../common/utils/Styles.dart';
import '../../common/utils/app_constants.dart';
import '../../common/utils/color_constants.dart';
import '../../common/utils/utility.dart';
import '../../controller/login_controller.dart';
import '../../routes/app_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LoginController loginScreenController = Get.put((LoginController()));
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          blur: 5,
          progressIndicator: Utils.loader(context),
          inAsyncCall: loginScreenController.isLoading.value,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),

                // for setting bg image
/*
                height: height - 120.sp,
*/

                width: 1.sw,
                child: Form(
                  key: loginScreenController.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils.addGap(55),
                        Center(
                          child: Text(
                            "Log In",
                            style: Styles.textFontRegular(
                                size: 32,
                                weight: FontWeight.w500,
                                color: AppColors.appColor),
                          ),
                        ),
                        Utils.addGap(55),
                        Text(
                          "Welcome back!",
                          style: Styles.textFontRegular(
                              size: 22,
                              weight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Utils.addGap(10),
                        Text(
                          "Login to your account",
                          style: Styles.textFontRegular(
                              size: 16,
                              weight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        Utils.addGap(30),
                        getTextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return AppConstants.errorEmail;
                            }
                            if (!Utils.isEmail(value)) {
                              return AppConstants.validEmail;
                            }

                            return null;
                          },
                          controller: loginScreenController.emailController,
                          isObscureText: false,
                          onChanged: (String value) {},
                          hintText: "Enter Email",
                          labelText: "Email",
                          passwordButton: Padding(
                            padding: const EdgeInsets.all(8.0),
                          ),
                        ),
                        Utils.addGap(20),
                        getTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppConstants.passwordK;
                            }
                            return null;
                          },
                          isObscureText: obscureText,
                          passwordButton: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.appblue,
                            ),
                            onPressed: () {
                              print(obscureText);
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          controller: loginScreenController.passwordController,
                          onChanged: (String value) {},
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        Utils.addGap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.forgotpassword);
                              },
                              child: Text(
                                "Forgot Password",
                                style: Styles.textFontRegular(
                                    size: 14,
                                    weight: FontWeight.w400,
                                    color: AppColors.appblue),
                              ),
                            ),
                          ],
                        ),
                        Utils.addGap(20),
                        Row(
                          children: [
                            Checkbox(
                              value: loginScreenController.accepted.value,
                              activeColor: AppColors.appblue,
                              onChanged: (newValue) => setState(() =>
                                  loginScreenController.accepted.value =
                                      newValue!),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'I accept ',
                                      style: Styles.textFontRegular(
                                          size: 12.sp,
                                          weight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    TextSpan(
                                      text:
                                          'Terms & Conditions and Privacy Policy',
                                      style: Styles.textFontRegular(
                                          size: 12.sp,
                                          weight: FontWeight.w500,
                                          color: AppColors.appblue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async => await launchUrl(
                                            Uri.parse(
                                                "https://www.pneumec.in/privacy-policy-2/")),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Utils.addGap(30),
                        RoundedButton(
                            buttonText: AppConstants.login.toUpperCase(),
                            height: 44,
                            color: AppColors.appColor.shade800,
                            width: 1.sw,
                            onpressed: () {
                              //Get.offAllNamed(Routes.dashboard);
                              print("button clicked");
                              loginScreenController.validate(context);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
